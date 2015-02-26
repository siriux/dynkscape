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
