class Navigation extends AnimationObject
  @main
  @active
  @mainNavigationContainer: null # Static for the main navigation
  @byName: {}

  constructor: (element, meta) ->

    mnav =
      if meta?
        @isMain = false
        meta.navigation
      else
        @isMain = true
        # TODO Try to get from control
        layer: ""

    if @isMain
      super(element, svgPageWidth, svgPageHeight, true) # Raw
    else
      super(element)

    @viewport = new Viewport(mnav.layer, $(@element).find(".viewport")[0])
    @name = @viewport.name

    if @isMain
      Navigation.main = this

      # Fix control on screen
      @control = $(@element).find(".mainNavigationControl")[0]
      m = actualMatrix(@control)
      Snap(@control).transform(m)
      sSvg.append(@control)
    else
      @control = $(@element).find(".navigationControl")[0]

    @_loadSlides()
    @_initUserNavigation()
    @_initNavigationControl()

    @_setLock(mnav.hasOwnProperty("lock") && mnav.lock != false)
    @_setShowViews(mnav.hasOwnProperty("showViews") && mnav.showViews != false)
    @_setActive(@viewport.isMain)

    Navigation.byName[@name] = this

    if mnav.start?
      @goTo(mnav.start, true) # Go skipping animation
    else
      @_setCurrentView(null)

  _loadSlides: () =>
    @slidesLayer = @viewport.layer.slidesLayer

    # Set the slides layer on top
    se = @slidesLayer.element
    $(se).appendTo(se.parentNode)

    # Slides
    @slideIndexByName = {}
    @slideList = []
    if @slidesLayer?
      processInkscapeMetaDescs @slidesLayer.element, (e, meta) =>
        if meta.hasOwnProperty('view')
          s = new Slide(e, meta)
          @slideList.push(s)
      @slideList.sort (a, b) -> a.index - b.index
      @slideIndexByName[v.name] = i for v, i in @slideList

    # Make slides clickable
    for s, i in @slideList
      e = s.element
      do (i) =>
        $(e).click () =>
          @goTo(i)
          @_setShowViews(false)

    # Full View
    @fullView = new AnimationObject(@viewport.element, 0, 0, true)
    @fullView.viewState = @viewport.state.clone()
    @fullView.duration = 1000
    @fullView.easing = "inout"

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

  _setCurrentView: (n) =>
    @currentView = n
    @currentSlideElementText?.textContent = if n? then n else "-"

    v = @slideList[@currentView]
    if v?.animation?
      $(@animationElements).css(opacity: 1)
      v.animation.labelChangedCallback = @_updateCurrentLabel
      v.animation.goStart()
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
    v = @slideList[@currentView]
    if v?.animation?
      @currentLabelElementText?.textContent = n

      if n == 0
        $(@prevLabelElement).css(opacity: 0.1)
        $(@animStartElement).css(opacity: 0.1)
      else
        $(@prevLabelElement).css(opacity: 1)
        $(@animStartElement).css(opacity: 1)

      if n == v.animation.labels.length - 1
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
    prevX = 0
    prevY = 0
    dragging = false
    panning = false

    startMove = (e) =>
      prevX = e.originalEvent.clientX
      prevY = e.originalEvent.clientY

    stopMove = () =>
      dragging = false
      panning = false

    $(@viewport.element)
      .mousemove (e) =>
        if not @lock
          if e.ctrlKey
            if not (dragging or panning)
              startMove(e)
            panning = true
          else
            panning = false

          if dragging or panning
            x = e.originalEvent.clientX
            y = e.originalEvent.clientY

            dx = (x - prevX) / svgPageScale
            dy = (y - prevY) / svgPageScale

            @viewport.translate(dx,dy)

            prevX = x
            prevY = y

            @_setCurrentView(null)

            false

      .mousedown (e) =>
        if not @lock
          startMove(e)
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
          delta = e.originalEvent.wheelDelta || e.originalEvent.deltaY
          delta /= 500
          delta = 0.5 if delta > 0.5
          delta = -0.5 if delta < -0.5

          x = e.originalEvent.clientX
          y = e.originalEvent.clientY

          # Center relative to page
          cx = (x - svgPageOffsetX) / svgPageScale
          cy = (y - svgPageOffsetY) / svgPageScale

          if e.altKey # Rotate instead of zoom when Alt is pressed
            rotation = delta * 20
            @viewport.rotate(rotation, cx, cy)
          else
            scale = 1 + delta
            @viewport.scale(scale, cx, cy)

          @_setCurrentView(null)

          false # Avoid zooming on windows if ctrl is pressed

  getStateForMaximizedView: (view, centerPage = true) =>
    s = view.viewState.diff(@viewport.state)
    s.animationObject = @viewport.animationObject

    # Modify rotate point to be the current translate (corner of the viewport)
    cx = (@viewport.state.translateX - s.translateX) / svgPageWidth
    cy = (@viewport.state.translateY - s.translateY) / svgPageHeight
    s.center = [cx, cy]

    # Get scale factors needed to fit viewport in either direction
    viewportWidth =
      if @viewport.isMain
        svgPageCorrectedWidth
      else
        @viewport.width
    viewportHeight =
      if @viewport.isMain
        svgPageCorrectedHeight
      else
        @viewport.height

    viewportProportions = viewportWidth / viewportHeight

    scaleHorizontal = viewportWidth / view.width
    scaleVertical = viewportHeight / view.height

    scaleFactor = null # Final scale factor
    tx = 0
    ty = 0

    if scaleHorizontal > scaleVertical
      scaleFactor = scaleVertical
      # Center horizontally on viewport
      tx = ((view.height * viewportProportions) - view.width) * scaleFactor * @viewport.state.scaleX / 2
    else
      scaleFactor = scaleHorizontal
      # Center vertically on viewport
      ty = ((view.width / viewportProportions) - view.height) * scaleFactor * @viewport.state.scaleY / 2

    if @viewport.isMain and centerPage
      # Correct page centering on the viewport
      if svgProportions > viewportProportions
        ty -= ((viewportHeight - (viewportWidth / svgProportions)) / 2)
      else
        tx -= ((viewportWidth - (viewportHeight * svgProportions)) / 2)

    s.translateX += tx
    s.translateY += ty

    s.scaleX *= scaleFactor
    s.scaleY *= scaleFactor
    s

  goToView: (view, skipAnimation = false, centerPage = true) =>
    dest = @getStateForMaximizedView(view, centerPage)
    ao = @viewport.animationObject

    if (view.duration == 0 or skipAnimation)
      ao.currentState = dest
      ao.applyCurrent()
    else
      current = ao.currentState

      # TODO Improve on real center of dest, instead of corner ??
      # Set center to have a more direct animation
      current.changeCenter(dest.center)

      diff = current.diff(dest)

      ctx = new ActionContext()
      ctx.duration = view.duration
      ctx.easing = view.easing
      ctx.center = diff.center

      a = new Action()
      a.context = ctx
      a.translateX = diff.translateX
      a.translateY = diff.translateY
      a.scaleX = diff.scaleX
      a.scaleY = diff.scaleY
      a.rotation = diff.rotation

      time = 0

      @animating = true

      advanceTime = (delta) =>
        time += delta
        ao.addProvisionalAction(a, time)
        ao.applyProvisional()

      onEnd = () =>
        ao.addAction(a, time)
        ao.applyCurrent()
        @animating = false

      ba = new BaseAnimation(view.duration, advanceTime, onEnd)
      ba.play()

  goTo: (dest, skipAnimation = false) =>
    if not @animating
      if typeof dest is 'string'
        dest = @slideIndexByName[dest]

      @_setCurrentView(dest)
      v = @slideList[dest]

      if v?
        @goToView(v, skipAnimation)

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
      if @viewport.isMain
        @fullView.width = svgPageCorrectedWidth
        @fullView.height = svgPageCorrectedHeight
      else
        @fullView.width = @viewport.width
        @fullView.height = @viewport.height

      @_setCurrentView(null)

      @goToView(@fullView, false, false) # Don't skip animation, don't perform page centering

  viewPlay: () =>
    v = @slideList[@currentView]
    if v?.animation?
      $(@pauseElement).show()
      $(@playElement).hide()
      v.animation.play () =>
        $(@pauseElement).hide()
        $(@playElement).show()


  viewPause: () =>
    v = @slideList[@currentView]
    if v?.animation?
      $(@pauseElement).hide()
      $(@playElement).show()
      v.animation.pause()

  viewPlayLabel: () =>
    v = @slideList[@currentView]
    if v?.animation?
      @viewPause()
      v.animation.playLabel()

  viewAnimStart: () =>
    v = @slideList[@currentView]
    if v?.animation?
      v.animation.goStart()

  viewAnimEnd: () =>
    v = @slideList[@currentView]
    if v?.animation?
      v.animation.goEnd()

  viewPrevLabel: () =>
    v = @slideList[@currentView]
    if v?.animation?
      v.animation.prevLabel()

  viewNextLabel: () =>
    v = @slideList[@currentView]
    if v?.animation?
      v.animation.nextLabel()
