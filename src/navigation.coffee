class Navigation
  @mainNavigationContainer: null # Static for the main navigation
  @byName: {}

  constructor: (layerName, viewportEl, userNavigation = true) ->
    @_initWrappersAndContainer(layerName, viewportEl)
    @_initViewport()
    @_loadViews()

    if (userNavigation)
      @_initUserNavigation()

    Navigation.byName[@name] = this

  _initWrappersAndContainer: (layerName, viewportEl) ->
    contents = null

    # For layers, init a viewport that will clip the layer
    if (not layerName?) || layerName == ""
      @name = ""
      @isMain = true
      @viewport = sSvg.node
      @layer = mainLayer
      contents = (l.element for l in mainLayer.children)
    else
      viewEl = Snap(viewportEl)

      snapViewport = Snap(Navigation.mainNavigationContainer).g()

      # Create group background
      bg = snapViewport.rect(0,0,viewEl.attr("width"),viewEl.attr("height"))
      bg.attr
        fill: "rgba(0,0,0,0)" # Transparent
        transform: actualMatrix(viewEl) # TODO Remove transformations of parent? Is needed?

      # Clip the layer to the viewport
      clip = Snap(svgElement("clipPath"))
      clip.append(bg.clone())
      clip.attr(id: clip.id)
      snapViewport.append(clip)
      snapViewport.attr("clip-path": "url(##{clip.id})")

      @name = layerName
      @isMain = false
      @viewport = snapViewport.node
      @layer = inkscapeLayersByName[layerName]
      contents = @layer.element

    @container = Snap(@viewport).g().node
    $(@container).append(contents)

    if @isMain
      Navigation.mainNavigationContainer = @container

  _initViewport: () ->
    if (@isMain)
      @viewportWidth = $(window).width()
      @viewportHeight = $(window).height()
      @viewportMatrix = new Snap.Matrix()
    else
      # Get clipping screen dimensions of the viewport
      # Screen is used to be compatible with window size
      clipRect = Snap(@viewport).select("clipPath rect")
      clipGlobaM = globalMatrix(clipRect)
      clipScale = matrixScaleX(clipGlobaM)

      @viewportWidth = clipRect.attr("width") * clipScale
      @viewportHeight = clipRect.attr("height") * clipScale

      @viewportMatrix = actualMatrix(clipRect)

    @viewportProportions = @viewportWidth/@viewportHeight

  _loadViews: () =>
    slidesLayer = @layer.slidesLayer
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
    containerMatrix = null
    transformMatrix = null
    prevX = 0
    prevY = 0
    dragging = false
    panning = false

    getTransformedFromEvent = (e) =>
      transformPointWithMatrix(transformMatrix, e.originalEvent.clientX, e.originalEvent.clientY)

    updateTransformMatrix = () =>
      transformMatrix = globalMatrix(@container).invert()

    startMove = (e) =>
      containerMatrix = localMatrix(@container)
      updateTransformMatrix()
      p = getTransformedFromEvent(e)
      prevX = p.x
      prevY = p.y

    stopMove = () =>
      dragging = false
      panning = false

    $(@viewport)
      .mousemove (e) =>
        if e.ctrlKey
          if not (dragging or panning)
            startMove(e)
          panning = true
        else
          panning = false

        if dragging or panning
          p = getTransformedFromEvent(e) # Don't update the matrix !!
          newM = containerMatrix.clone().translate(p.x - prevX, p.y - prevY)
          @_applyMatrix(newM)
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

        updateTransformMatrix()
        p = getTransformedFromEvent(e)

        if e.altKey # Rotate instead of zoom when Alt is pressed
          rotation = delta * 20
          newM = localMatrix(@container)
            .translate(p.x, p.y)
            .rotate(rotation)
            .translate(-p.x, -p.y)
        else
          scale = 1 + delta
          newM = localMatrix(@container)
            .translate(p.x, p.y)
            .scale(scale)
            .translate(-p.x, -p.y)

        @_applyMatrix(newM)

        false # Avoid zooming on windows if ctrl is pressed

  _applyMatrix: (m, animate) =>
    # .toTransformString() is needed to be able to animate
    if animate?
      # TODO Improve animation. Rotation + Zoom is weird
      # TODO Optimize animation performance !!!
      Snap(@container).animate({ transform: m.toTransformString() }, animate.duration, animate.easing)
    else
      Snap(@container).transform(m.toTransformString())

  _navigateToView: (view, animate) =>
    # Get scale factors needed to fit viewport in either direction
    scaleHorizontal = @viewportWidth / (view.scale * view.width)
    scaleVertical = @viewportHeight / (view.scale * view.height)

    scaleFactor = null # Final scale factor
    tx = 0
    ty = 0

    if scaleHorizontal > scaleVertical
      scaleFactor = scaleVertical
      tx = ((view.height * @viewportProportions) - view.width) / 2 # Center horizontally on window
    else
      scaleFactor = scaleHorizontal
      ty = ((view.width / @viewportProportions) - view.height) / 2 # Center vertically on window

    if @isMain
      # Correct page centering on the viewport
      if svgProportions > @viewportProportions
        ty -= ((@viewportHeight - (@viewportWidth / svgProportions)) / 2) / (scaleFactor*view.scale)
      else
        tx -= ((@viewportWidth - (@viewportHeight * svgProportions)) / 2) / (scaleFactor*view.scale)

    finalMatrix = new Snap.Matrix()
      .add(@viewportMatrix) # Center on viewport
      .scale(scaleFactor, scaleFactor)
      .translate(tx,ty)
      .add(view.actualMatrixInverse)

    @_applyMatrix(finalMatrix, animate)

  goHome: (animate) =>
    @_applyMatrix(new Snap.Matrix(), animate)

  goNext: (animate) =>

    inc = () =>
      if (@currentView + 1) < @viewList.length
        @currentView += 1

        if not @viewList[@currentView]?
          inc()

    if @currentView?
      inc()
    else
      @currentView = 0

    @goTo(@currentView, animate)

  goPrev: (animate) =>

    dec = () =>
      if @currentView > 0
        @currentView -= 1

        if not @viewList[@currentView]?
          dec()

    if @currentView?
      dec()
    else
      @currentView = 0

    @goTo(@currentView, animate)

  goTo: (dest, animate) =>
    if typeof dest is 'string'
      v = @viewsByName[dest]

    if typeof dest is 'number'
      @currentView = dest
      v = @viewList[dest]

    if v?
      @_navigateToView v, animate

  playCurrentView: (dest) ->
    v = @viewList[@currentView]
    if v?
      v.play(dest)
