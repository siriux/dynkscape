class Navigation
  @main
  @active
  @mainNavigationContainer: null # Static for the main navigation
  @byName: {}

  constructor: (@element, meta) ->
    mnav = if meta?
      meta.navigation
    else
      # TODO Try to get from control
      navigation: layer: ""

    @viewport = new Viewport(mnav.layer, $(@element).find(".viewport")[0])
    @name = @viewport.name

    if @viewport.isMain
      Navigation.main = this

      # Fix control on screen
      @control = $(@element).find(".mainNavigationControl")[0]
      m = actualMatrix(@control)
      Snap(@control).transform(m)
      sSvg.append(@control)
    else
      @control = $(@element).find(".navigationControl")[0]

    @_loadViews()
    @_initUserNavigation()
    @_initNavigationControl()

    @_setLock(mnav.hasOwnProperty('lock') && mnav.lock != false)
    @_setShowViews(mnav.hasOwnProperty('showViews') && mnav.showViews != false)
    @_setActive(@viewport.isMain)

    Navigation.byName[@name] = this

    if mnav.start?
      @goTo(mnav.start)
    else
      @_setCurrentView(null)

  _loadViews: () =>
    # Views
    @slidesLayer = @viewport.layer.slidesLayer
    @viewIndexByName = {}
    @viewList = []
    if @slidesLayer?
      processInkscapeMetaDescs @slidesLayer.element, (e, meta) =>
        if meta.hasOwnProperty('view')
          v = View.fromElement(e, meta)
          @viewList.push(v)
      @viewList.sort (a, b) -> a.index - b.index
      @viewIndexByName[v.name] = i for v, i in @viewList

    # Full View
    @fullView = new View()
    @fullView.state = @viewport.state
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
    @currentSlideElement?.textContent = if n? then n else "-"

  _initNavigationControl: () ->
    @lockElement = $(@control).find(".lock")[0]
    @showViewsElement = $(@control).find(".showViews")[0]
    @activeCueElement = $(@control).find(".activeCue")[0]
    @currentSlideElement = $(@control).find(".currentSlide tspan")[0]
    @currentPlayElement = $(@control).find(".play")[0]
    @currentPauseElement = $(@control).find(".pause").hide()[0]

    $(@control).click () =>
      Navigation.active._setActive(false)
      @_setActive(true)

    $(@control).find(".homeSlide").click () => @goTo(0)
    $(@control).find(".prevSlide").click () => @goPrev()
    $(@control).find(".nextSlide").click () => @goNext()
    $(@lockElement).click () => @_setLock(not @lock)
    $(@showViewsElement).click () => @_setShowViews(not @showViews)
    $(@control).find(".fullView").click () => @goFull()

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

  _getStateForMaximizedView: (view, centerPage = true) =>
    s = view.state.diff(@viewport.state)
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

  goToView: (view, centerPage = true) =>
    dest = @_getStateForMaximizedView(view, centerPage)
    ao = @viewport.animationObject

    if (view.duration == 0)
      ao.currentState = dest
      ao.apply()
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
        ao.apply()
        @animating = false

      animate(view.duration, advanceTime, onEnd)

  goTo: (dest) =>
    if not @animating
      if typeof dest is 'string'
        dest = @viewIndexByName[dest]

      @_setCurrentView(dest)
      v = @viewList[dest]

      if v?
        @goToView(v)

  goPrev: () =>
    if @viewList.length > 0
      n = @currentView
      if n?
        n -= 1
        if n < 0
          n = 0
      else
        n = 0
      @goTo(n)

  goNext: () =>
    if @viewList.length > 0
      n = @currentView
      if n?
        n += 1
        if n > @viewList.length - 1
          n = @viewList.length - 1
      else
        n = 0
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

      @goToView(@fullView, false) # Don't perform page centering
