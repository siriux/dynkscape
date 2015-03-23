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

    @viewList = []

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
    @_setShowSlides(@meta.navigation.hasOwnProperty("showSlides") && @meta.navigation.showSlides != false)
    @_setActive(@isMain)

    if @meta.navigation.start?
      @goTo(@meta.navigation.start, true) # Go skipping animation
    else
      @_setCurrentView(null)

  _setLock: (isLocked) =>
    @lock = isLocked
    if isLocked
      $(@lockElement).css(opacity: 1)
    else
      $(@lockElement).css(opacity: 0.1)

  _setShowSlides: (areShown) =>
    @showSlides = areShown
    if areShown and @slidesLayer?
      $(@showSlidesElement).css(opacity: 1)
      @slidesLayer.show()
    else
      $(@showSlidesElement).css(opacity: 0.1)
      @slidesLayer?.hide()

  _setActive: (isActive) =>
    if isActive
      Navigation.active = this
      $(@activeCueElement).css(opacity: 1)
    else
      $(@activeCueElement).css(opacity: 0.1)

  _setCurrentView: (n) =>
    @currentView = n
    @currentViewElementText?.textContent = if n? then n else "-"

    s = @viewList[@currentView]
    if s?.mainAnimation?
      $(@animationElements).css(opacity: 1)
      s.mainAnimation.labelChangedCallback = @_updateCurrentLabel
      s.mainAnimation.goStart()
    else
      $(@animationElements).css(opacity: 0.1)
      @currentLabelElementText?.textContent = "-"

    if not n? or n == 0
      $(@prevViewElement).css(opacity: 0.1)
    else
      $(@prevViewElement).css(opacity: 1)

    if not n? or n == @viewList.length - 1
      $(@nextViewElement).css(opacity: 0.1)
    else
      $(@nextViewElement).css(opacity: 1)

    if not n?
      $(@currentViewElementText).css(opacity: 0.1)
    else
      $(@currentViewElementText).css(opacity: 1)

  _updateCurrentLabel: (n) =>
    s = @viewList[@currentView]
    if s?.mainAnimation?
      @currentLabelElementText?.textContent = n

      if n == 0
        $(@prevLabelElement).css(opacity: 0.1)
        $(@animStartElement).css(opacity: 0.1)
      else
        $(@prevLabelElement).css(opacity: 1)
        $(@animStartElement).css(opacity: 1)

      if n == s.mainAnimation.labels.length - 1
        $(@nextLabelElement).css(opacity: 0.1)
        $(@animEndElement).css(opacity: 0.1)
      else
        $(@nextLabelElement).css(opacity: 1)
        $(@animEndElement).css(opacity: 1)

  _initNavigationControl: () ->

    @activeCueElement = $(@control).find(".activeCue")[0]
    @homeViewElement = $(@control).find(".homeSlide")[0]
    @prevViewElement = $(@control).find(".prevSlide")[0]
    @currentViewElement = $(@control).find(".currentSlide")[0]
    @currentViewElementText = $(@currentViewElement).find("tspan")[0]
    @nextViewElement = $(@control).find(".nextSlide")[0]
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
    @showSlidesElement = $(@control).find(".showViews")[0]
    @fullViewElement = $(@control).find(".fullView")[0]
    @animationElements = [@playElement,@pauseElement,@playLabelElement,@animStartElement,@prevLabelElement,@currentLabelElement,@nextLabelElement,@animEndElement]

    $(@control).click () =>
      Navigation.active._setActive(false)
      @_setActive(true)

    $(@homeViewElement).click () => @goTo(0)
    $(@prevViewElement).click () => @goPrev()
    $(@nextViewElement).click () => @goNext()

    $(@playElement).click () => @viewPlay()
    $(@pauseElement).click () => @viewPause()
    $(@playLabelElement).click () => @viewPlayLabel()
    $(@animStartElement).click () => @viewAnimStart()
    $(@prevLabelElement).click () => @viewPrevLabel()
    $(@nextLabelElement).click () => @viewNextLabel()
    $(@animEndElement).click () => @viewAnimEnd()

    $(@lockElement).click () => @_setLock(not @lock)
    $(@showSlidesElement).click () => @_setShowSlides(not @showSlides)
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

            @_setCurrentView(null)
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

          @_setCurrentView(null)
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
    if @viewList.length > 0 and not @animating
      @_setCurrentView(dest)
      s = @viewList[dest]

      if s?
        @goToView(s, skipAnimation)

  goPrev: () =>
    if @viewList.length > 0
      n = @currentView
      if n?
        n -= 1
        if n < 0
          n = 0
        @goTo(n)

  goNext: () =>
    if @viewList.length > 0
      n = @currentView
      if n?
        n += 1
        if n > @viewList.length - 1
          n = @viewList.length - 1
        @goTo(n)

  goFull: () =>
    if not @animating
      @_setCurrentView(null)

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
      # TODO Save lock, showSlides
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
      @_setCurrentView(null)
    else
      @goTo(v, skipAnimation)

  viewPlay: () =>
    v = @viewList[@currentView]
    if v?.mainAnimation?
      $(@pauseElement).show()
      $(@playElement).hide()
      v.mainAnimation.play () =>
        $(@pauseElement).hide()
        $(@playElement).show()


  viewPause: () =>
    v = @viewList[@currentView]
    if v?.mainAnimation?
      $(@pauseElement).hide()
      $(@playElement).show()
      v.mainAnimation.pause()

  viewPlayLabel: () =>
    v = @viewList[@currentView]
    if v?.mainAnimation?
      @viewPause()
      v.mainAnimation.playLabel()

  viewAnimStart: () =>
    v = @viewList[@currentView]
    if v?.mainAnimation?
      v.mainAnimation.goStart()

  viewAnimEnd: () =>
    v = @viewList[@currentView]
    if v?.mainAnimation?
      v.mainAnimation.goEnd()

  viewPrevLabel: () =>
    v = @viewList[@currentView]
    if s?.mainAnimation?
      v.mainAnimation.prevLabel()

  viewNextLabel: () =>
    v = @viewList[@currentView]
    if v?.mainAnimation?
      v.mainAnimation.nextLabel()
