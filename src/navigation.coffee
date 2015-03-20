class Navigation extends AnimationObject
  @main
  @active
  @mainNavigationContainer: null

  constructor: (element, meta) ->
    if meta.navigation.content == Layer.main.fullName
      @isMain = true
      Navigation.main = this
    else
      @isMain = false

    super(element, meta, null, null, true)

    @setBase(State.fromMatrix(localMatrix(@element)))

    @slideList = []

  init: () =>
    super()

    content = AnimationObject.byFullName[@meta.navigation.content]

    viewportAO = AnimationObject.byFullName["#{@fullName}.viewport"]

    @viewport = new NavigationViewport(content, viewportAO, this)

    # Set the slides layer on top
    @slidesLayer = content.slidesLayer # content is a slide, and has a slides layer
    if @slidesLayer?
      se = @slidesLayer.element
      $(se).appendTo(se.parentNode)

    @control = $(@element).children(".navigationControl")[0]

    @_initUserNavigation()
    @_initNavigationControl()

    @_setLock(@meta.navigation.hasOwnProperty("lock") && @meta.navigation.lock != false)
    @_setShowViews(@meta.navigation.hasOwnProperty("showViews") && @meta.navigation.showViews != false)
    @_setActive(@isMain)

    if @meta.navigation.start?
      @goTo(@meta.navigation.start, true) # Go skipping animation
    else
      @_setCurrentSlide(null)

  _setLock: (isLocked) =>
    @lock = isLocked
    if isLocked
      $(@lockElement).css(opacity: 1)
    else
      $(@lockElement).css(opacity: 0.1)

  _setShowViews: (areShown) =>
    @showViews = areShown
    if areShown and @slidesLayer?
      $(@showViewsElement).css(opacity: 1)
      @slidesLayer.show()
    else
      $(@showViewsElement).css(opacity: 0.1)
      @slidesLayer?.hide()

  _setActive: (isActive) =>
    if isActive
      Navigation.active = this
      $(@activeCueElement).css(opacity: 1)
    else
      $(@activeCueElement).css(opacity: 0.1)

  _setCurrentSlide: (n) =>
    @currentView = n
    @currentSlideElementText?.textContent = if n? then n else "-"

    s = @slideList[@currentView]
    if s?.slideAnimation?
      $(@animationElements).css(opacity: 1)
      s.slideAnimation.labelChangedCallback = @_updateCurrentLabel
      s.slideAnimation.goStart()
    else
      $(@animationElements).css(opacity: 0.1)
      @currentLabelElementText?.textContent = "-"

    if not n? or n == 0
      $(@prevSlideElement).css(opacity: 0.1)
    else
      $(@prevSlideElement).css(opacity: 1)

    if not n? or n == @slideList.length - 1
      $(@nextSlideElement).css(opacity: 0.1)
    else
      $(@nextSlideElement).css(opacity: 1)

    if not n?
      $(@currentSlideElementText).css(opacity: 0.1)
    else
      $(@currentSlideElementText).css(opacity: 1)

  _updateCurrentLabel: (n) =>
    s = @slideList[@currentView]
    if s?.slideAnimation?
      @currentLabelElementText?.textContent = n

      if n == 0
        $(@prevLabelElement).css(opacity: 0.1)
        $(@animStartElement).css(opacity: 0.1)
      else
        $(@prevLabelElement).css(opacity: 1)
        $(@animStartElement).css(opacity: 1)

      if n == s.slideAnimation.labels.length - 1
        $(@nextLabelElement).css(opacity: 0.1)
        $(@animEndElement).css(opacity: 0.1)
      else
        $(@nextLabelElement).css(opacity: 1)
        $(@animEndElement).css(opacity: 1)

  _initNavigationControl: () ->

    @activeCueElement = $(@control).find(".activeCue")[0]
    @homeSlideElement = $(@control).find(".homeSlide")[0]
    @prevSlideElement = $(@control).find(".prevSlide")[0]
    @currentSlideElement = $(@control).find(".currentSlide")[0]
    @currentSlideElementText = $(@currentSlideElement).find("tspan")[0]
    @nextSlideElement = $(@control).find(".nextSlide")[0]
    @playElement = $(@control).find(".play")[0]
    @pauseElement = $(@control).find(".pause").hide()[0]
    @playLabelElement = $(@control).find(".playLabel")[0]
    @animStartElement = $(@control).find(".animStart")[0]
    @prevLabelElement = $(@control).find(".prevLabel")[0]
    @currentLabelElement = $(@control).find(".currentLabel")[0]
    @currentLabelElementText = $(@currentLabelElement).find("tspan")[0]
    @nextLabelElement = $(@control).find(".nextLabel")[0]
    @animEndElement = $(@control).find(".animEnd")[0]
    @lockElement = $(@control).find(".lock")[0]
    @showViewsElement = $(@control).find(".showViews")[0]
    @fullViewElement = $(@control).find(".fullView")[0]
    @animationElements = [@playElement,@pauseElement,@playLabelElement,@animStartElement,@prevLabelElement,@currentLabelElement,@nextLabelElement,@animEndElement]

    $(@control).click () =>
      Navigation.active._setActive(false)
      @_setActive(true)

    $(@homeSlideElement).click () => @goTo(0)
    $(@prevSlideElement).click () => @goPrev()
    $(@nextSlideElement).click () => @goNext()

    $(@playElement).click () => @viewPlay()
    $(@pauseElement).click () => @viewPause()
    $(@playLabelElement).click () => @viewPlayLabel()
    $(@animStartElement).click () => @viewAnimStart()
    $(@prevLabelElement).click () => @viewPrevLabel()
    $(@nextLabelElement).click () => @viewNextLabel()
    $(@animEndElement).click () => @viewAnimEnd()

    $(@lockElement).click () => @_setLock(not @lock)
    $(@showViewsElement).click () => @_setShowViews(not @showViews)
    $(@fullViewElement).click () => @goFull()

  _initUserNavigation: () ->
    prev = null
    dragging = false
    panning = false

    getTransformedPoint = (e) =>
      cursor =
        x: e.clientX
        y: e.clientY
      @viewport.transformPointToCurrent(cursor, true) # exclude own transform

    stopMove = () =>
      dragging = false
      panning = false

    $(@viewport.viewportElement)
      .mousemove (e) =>
        if not @lock
          if e.ctrlKey
            if not (dragging or panning)
              prev = getTransformedPoint(e)
            panning = true
          else
            panning = false

          if dragging or panning
            p = getTransformedPoint(e)

            delta =
              x: p.x - prev.x
              y: p.y - prev.y

            adjustedDelta = @viewport.baseState.scaleRotatePoint(delta)

            @viewport.translate(adjustedDelta)

            prev = p

            @_setCurrentSlide(null)
            @updateReferenceState()

            false

      .mousedown (e) =>
        if not @lock
          prev = getTransformedPoint(e)
          dragging = true
          false

      .mouseup (e) =>
        if not @lock
          stopMove()
          false

      .mouseleave (e) =>
        if not @lock
          stopMove()
          false

      .on "mousewheel wheel", (e) =>
        if not @lock
          stopMove() # Stop any pending move

          # Try to normalize across browsers.
          delta = e.wheelDelta || e.deltaY
          delta /= 500
          delta = 0.5 if delta > 0.5
          delta = -0.5 if delta < -0.5

          center = @viewport.transformPointToCurrent
            x: e.clientX
            y: e.clientY

          if e.altKey # Rotate instead of zoom when Alt is pressed
            rotation = delta * 20
            @viewport.rotate(rotation, center)
          else
            scale = 1 + delta
            @viewport.scale(scale, center)

          @_setCurrentSlide(null)
          @updateReferenceState()

          false # Avoid zooming on windows if ctrl is pressed

  goToView: (view, skipAnimation = false, centerPage = true) =>
    dest = @viewport.getStateForMaximizedView(view, centerPage)
    @goToState(dest, skipAnimation, view.duration, view.easing)

  goToState: (dest, skipAnimation = false, duration, easing) =>
    if (duration == 0 or skipAnimation)
      @viewport.currentState = dest
      @viewport.applyCurrent()
    else
      current = @viewport.currentState

      # TODO Improve on real center of dest, instead of corner ??
      # Set center to have a more direct animation
      current.changeCenter(dest.center)

      diff = current.diff(dest)

      a = new Action "transform",
        time: 0
        target: @viewport
        translateX: diff.translateX
        translateY: diff.translateY
        scaleX: diff.scaleX
        scaleY: diff.scaleY
        rotate: diff.rotation
        center: diff.center
        duration: duration ? 1
        easing: easing ? "inout"

      @animating = true
      anim = a.getAnim () =>
        @animating = false
        @updateReferenceState()
      anim.play()

  goTo: (dest, skipAnimation = false) =>
    if @slideList.length > 0 and not @animating
      @_setCurrentSlide(dest)
      s = @slideList[dest]

      if s?
        @goToView(s, skipAnimation)

  goPrev: () =>
    if @slideList.length > 0
      n = @currentView
      if n?
        n -= 1
        if n < 0
          n = 0
        @goTo(n)

  goNext: () =>
    if @slideList.length > 0
      n = @currentView
      if n?
        n += 1
        if n > @slideList.length - 1
          n = @slideList.length - 1
        @goTo(n)

  goFull: () =>
    if not @animating
      @_setCurrentSlide(null)

      @goToState(@viewport.baseState, false, 1, "inout") # Don't skip animation, don't perform page centering

  saveReferenceState: () => newReferenceState(@reference)

  updateReferenceState: () =>
    updateReferenceState @reference, (s) =>
      if @currentView?
        s.view = @currentView
      else
        viewState = @viewport.currentState
        s.view =
          translateX: viewState.translateX
          translateY: viewState.translateY
          scaleX: viewState.scaleX
          scaleY: viewState.scaleY
          rotation: viewState.rotation
          center: viewState.center

      # TODO Save Active
      # TODO Save lock, showViews
      # TODO Animation state

  applyReferenceState: (s, skipAnimation = false) =>
    v = s.view
    if v instanceof Object
      dest = new State()
      dest.translateX = v.translateX
      dest.translateY = v.translateY
      dest.scaleX = v.scaleX
      dest.scaleY = v.scaleY
      dest.rotation = v.rotation
      dest.center = v.center
      dest.animationObject = @viewport.currentState.animationObject
      @goToState(dest, skipAnimation)
      @_setCurrentSlide(null)
    else
      @goTo(v, skipAnimation)

  viewPlay: () =>
    s = @slideList[@currentView]
    if s?.slideAnimation?
      $(@pauseElement).show()
      $(@playElement).hide()
      s.slideAnimation.play () =>
        $(@pauseElement).hide()
        $(@playElement).show()


  viewPause: () =>
    s = @slideList[@currentView]
    if s?.slideAnimation?
      $(@pauseElement).hide()
      $(@playElement).show()
      s.slideAnimation.pause()

  viewPlayLabel: () =>
    s = @slideList[@currentView]
    if s?.slideAnimation?
      @viewPause()
      s.slideAnimation.playLabel()

  viewAnimStart: () =>
    s = @slideList[@currentView]
    if s?.slideAnimation?
      s.slideAnimation.goStart()

  viewAnimEnd: () =>
    s = @slideList[@currentView]
    if s?.slideAnimation?
      s.slideAnimation.goEnd()

  viewPrevLabel: () =>
    s = @slideList[@currentView]
    if s?.slideAnimation?
      s.slideAnimation.prevLabel()

  viewNextLabel: () =>
    s = @slideList[@currentView]
    if s?.slideAnimation?
      s.slideAnimation.nextLabel()
