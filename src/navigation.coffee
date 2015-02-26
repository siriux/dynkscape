class Navigation
  @mainNavigationContainer: null # Static for the main navigation
  @byName: {}

  constructor: (layerName, viewportEl, userNavigation = true) ->
    @viewport = new Viewport(layerName, viewportEl)
    @name = @viewport.name
    @_loadViews()

    if (userNavigation)
      @_initUserNavigation()

    Navigation.byName[@name] = this

  _loadViews: () =>
    slidesLayer = @viewport.layer.slidesLayer
    @viewsByName = {}
    @viewList = []
    @currentView = null
    if slidesLayer?
      processInkscapeMetaDescs slidesLayer.element, (e, meta) =>
        if meta.hasOwnProperty('view')
          v = new View(e, meta)
          @viewsByName[v.id] = v # TODO Allow to define name in meta !!!
          if v.index?
            @viewList[v.index] = v

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
          false

      .mousedown (e) =>
        startMove(e)
        dragging = true
        false

      .mouseup (e) =>
        stopMove()
        false

      .mouseleave (e) =>
        stopMove()
        false

      .on "mousewheel wheel", (e) =>
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

        false # Avoid zooming on windows if ctrl is pressed

  _getStateForMaximizedView: (view) =>
    s = view.state.diff(@viewport.state)
    s.animationObject = @viewport.animationObject
    @viewport.animationObject.currentState = s

    # Modify rotate point to be the current translate (corner of the viewport)
    s.center = [-s.translateX / svgPageWidth, -s.translateY / svgPageHeight]

    # Get scale factors needed to fit viewport in either direction
    viewportWidth = if @viewport.isMain then svgPageCorrectedWidth else @viewport.width
    viewportHeight = if @viewport.isMain then svgPageCorrectedHeight else @viewport.height
    viewportProportions = viewportWidth / viewportHeight

    scaleHorizontal = viewportWidth / view.width
    scaleVertical = viewportHeight / view.height

    scaleFactor = null # Final scale factor
    tx = 0
    ty = 0

    if scaleHorizontal > scaleVertical
      scaleFactor = scaleVertical
      tx = ((view.height * viewportProportions) - view.width) / 2 # Center horizontally on window
    else
      scaleFactor = scaleHorizontal
      ty = ((view.width / viewportProportions) - view.height) / 2 # Center vertically on window

    if @viewport.isMain
      # Correct page centering on the viewport
      if svgProportions > viewportProportions
        ty -= ((viewportHeight - (viewportWidth / svgProportions)) / 2) / scaleFactor
      else
        tx -= ((viewportWidth - (viewportHeight * svgProportions)) / 2) / scaleFactor

    s.translateX += tx * scaleFactor
    s.translateY += ty * scaleFactor

    s.scaleX *= scaleFactor
    s.scaleY *= scaleFactor

    s.changeCenter([0,0])

    s

  goToView: () =>
    view = @viewsByName["mainSlide0"]

    s = @_getStateForMaximizedView(view)

    s.apply()
