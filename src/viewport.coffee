class Viewport
  @main: null # Static for the main viewport

  constructor: (layerName, viewportEl) ->
    contents = null

    # For layers, init a viewport that will clip the layer
    if (not layerName?) || layerName == ""
      @name = ""
      @isMain = true
      @element = sSvg.node
      @layer = mainLayer

      @width = windowWidth
      @height = windowHeight

      contents = (l.element for l in mainLayer.children)
    else
      moveCoordsToMatrix(viewportEl)
      viewEl = Snap(viewportEl)

      snapViewport = Snap(Viewport.main.container).g()

      # Create group background
      bg = snapViewport.rect(0,0,viewEl.attr("width"),viewEl.attr("height"))
      bg.attr
        fill: "rgba(0,0,0,0)" # Transparent
        transform: actualMatrix(viewEl) # TODO Remove transformations of parent? Is needed?

      # Clip the layer to the viewport
      clip = Snap(svgElement("clipPath"))
      clipRect = bg.clone()
      clip.append(clipRect)
      clip.attr(id: clip.id)
      snapViewport.append(clip)
      snapViewport.attr("clip-path": "url(##{clip.id})")

      @name = layerName
      @isMain = false
      @element = snapViewport.node
      @layer = inkscapeLayersByName[layerName]

      # Get clipping screen dimensions of the viewport
      # Screen is used to be compatible with window size
      clipScale = matrixScaleX(globalMatrix(clipRect))
      @width = clipRect.attr("width") * clipScale
      @height = clipRect.attr("height") * clipScale

      contents = @layer.element

    @proportions = @width/@height

    @container = Snap(@element).g().node
    $(@container).append(contents)

    @animationObject = new AnimationObject(@container, svgPageWidth, svgPageHeight)
    base = new State()
    base.center = [0,0]
    @animationObject.setBase(base)

    if @isMain
      Viewport.main = this

  _getCenterPoint: (p) =>
    if not @isMain
      p = Viewport.main.animationObject.currentState.transformPointInverse(p)

    p = @animationObject.currentState.transformPointInverse(p)

    normalizeCX = p.x / svgPageWidth
    normalizeCY = p.y / svgPageHeight
    [normalizeCX, normalizeCY]

  translate: (x, y) =>
    p =
      x: x
      y: y

    if not @isMain
      p = Viewport.main.animationObject.currentState.scaleRotatePointInverse(p)

    s = @animationObject.currentState
    s.translateX += p.x
    s.translateY += p.y
    s.apply()

  scale: (scale, cx, cy) =>
    s = @animationObject.currentState

    s.changeCenter(@_getCenterPoint(x: cx, y: cy))

    s.scaleX *= scale
    s.scaleY *= scale

    s.changeCenter([0, 0])

    s.apply()

  rotate: (rotation, cx, cy) =>
    s = @animationObject.currentState

    s.changeCenter(@_getCenterPoint(x: cx, y: cy))

    s.rotation += rotation

    s.changeCenter([0, 0])

    s.apply()
