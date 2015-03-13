class NavigationViewport  extends AnimationObject
  @main: null # Static for the main viewport

  constructor: (@layer, viewportEl) ->
    contents = null

    if @layer.isMain()
      @isMain = true
      @clipElement = sSvg.node

      @viewportBaseState = new State()
      @viewportBaseState.center = [0,0] # To use the same default

      contents = (l.element for l in @layer.children)
    else
      viewEl = Snap(viewportEl)

      viewportMatrix = actualMatrix(viewEl.node) # TODO Remove transformations of parent? Is needed?

      snapViewport = Snap(NavigationViewport.main.element).g()

      # Create group background
      bg = snapViewport.rect(0,0,viewEl.attr("width"),viewEl.attr("height"))
      bg.attr
        fill: "rgba(0,0,0,0)" # Transparent
        transform: viewportMatrix

      # Clip the layer to the viewport
      clipRect = bg.clone()
      clip = createClip(clipRect)
      applyClip(snapViewport, clip)

      @isMain = false
      @clipElement = snapViewport.node

      @clipWidth = parseFloat(clipRect.attr("width")) or 0
      @clipHeight = parseFloat(clipRect.attr("height")) or 0
      @viewportBaseState = State.fromMatrix(viewportMatrix)

      # Replace the layer with @clipElement, needed to keep z-order
      $(@layer.element).replaceWith(@clipElement)

      contents = @layer.element

    container = Snap(@clipElement).g().node
    super(container, {}, svgPageWidth, svgPageHeight, true) # Raw, no clipping or compensation

    $(@element).append(contents)

    @setBase(new State())

    @viewportBaseState.animationObject = this

    if @isMain
      NavigationViewport.main = this

  getFullView: () =>
    fV = new AnimationObject(@element, {}, 0, 0, true)
    fV.viewState = @viewportBaseState.clone()
    fV.duration = 1000
    fV.easing = "inout"

    if @isMain
      fV.width = svgPageCorrectedWidth
      fV.height = svgPageCorrectedHeight
    else
      fV.width = @viewport.clipWidth
      fV.height = @viewport.clipHeight

    fV

  getStateForMaximizedView: (view, centerPage = true) =>
    s = view.viewState.diff(@viewportBaseState)
    s.animationObject = this

    # Modify rotate point to be the current translate (corner of the viewport)
    cx = (@viewportBaseState.translateX - s.translateX) / svgPageWidth
    cy = (@viewportBaseState.translateY - s.translateY) / svgPageHeight
    s.center = [cx, cy]

    # Get scale factors needed to fit viewport in either direction
    viewportWidth =
      if @isMain
        svgPageCorrectedWidth
      else
        @clipWidth
    viewportHeight =
      if @isMain
        svgPageCorrectedHeight
      else
        @clipHeight

    viewportProportions = viewportWidth / viewportHeight

    scaleHorizontal = viewportWidth / view.width
    scaleVertical = viewportHeight / view.height

    scaleFactor = null # Final scale factor
    tx = 0
    ty = 0

    if scaleHorizontal > scaleVertical
      scaleFactor = scaleVertical
      # Center horizontally on viewport
      tx = ((view.height * viewportProportions) - view.width) * scaleFactor * @viewportBaseState.scaleX / 2
    else
      scaleFactor = scaleHorizontal
      # Center vertically on viewport
      ty = ((view.width / viewportProportions) - view.height) * scaleFactor * @viewportBaseState.scaleY / 2

    if @isMain and centerPage
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

  _getCenterPoint: (p) =>
    if not @isMain
      p = Viewport.main.currentState.transformPointInverse(p)

    p = @currentState.transformPointInverse(p)

    normalizeCX = p.x / svgPageWidth
    normalizeCY = p.y / svgPageHeight
    [normalizeCX, normalizeCY]

  translate: (x, y) =>
    p =
      x: x
      y: y

    if not @isMain
      p = Viewport.main.currentState.scaleRotatePointInverse(p)

    s = @currentState
    s.translateX += p.x
    s.translateY += p.y
    s.apply()

  scale: (scale, cx, cy) =>
    s = @currentState

    s.changeCenter(@_getCenterPoint(x: cx, y: cy))

    s.scaleX *= scale
    s.scaleY *= scale

    s.changeCenter([0, 0])

    s.apply()

  rotate: (rotation, cx, cy) =>
    s = @currentState

    s.changeCenter(@_getCenterPoint(x: cx, y: cy))

    s.rotation += rotation

    s.changeCenter([0, 0])

    s.apply()