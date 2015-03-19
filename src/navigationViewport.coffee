class NavigationViewport  extends AnimationObject
  @main: null # Static for the main viewport

  constructor: (content, viewportEl, @parent) ->
    # Calculate matrices
    viewportLocal = actualMatrix(viewportEl, viewportEl.parentElement) # Local, including x and y
    viewportActual = actualMatrix(viewportEl)
    contentLocal = actualMatrix(content.element, content.element.parentElement) # Local, including x and y
    contentActual = actualMatrix(content.element)
    viewportReal = viewportLocal.multiply(viewportActual.inverse())
    contentReal = contentLocal.multiply(contentActual.inverse())
    base = viewportReal.multiply(contentReal.inverse())

    @viewportElement = svgElement("g")

    # Create background
    bg = svgElement("rect")
    @viewportElement.appendChild(bg)
    setAttrs bg,
      width: getFloatAttr(viewportEl, "width")
      height: getFloatAttr(viewportEl, "height")
      fill: "rgba(0,0,0,0)" # Transparent
    setTransform(bg, viewportLocal)

    # Clip the content to the viewport
    clipRect = bg.cloneNode(false)
    clip = createClip(clipRect, @viewportElement)
    applyClip(@viewportElement, clip)
    @clipWidth = getFloatAttr(clipRect, "width", 0)
    @clipHeight = getFloatAttr(clipRect, "height", 0)

    # Create container
    container = svgElement("g")
    $(container).append(content.element)
    @viewportElement.appendChild(container)

    # Insert after viewportElement after original viewportEl
    viewportEl.parentElement.insertBefore(@viewportElement, viewportEl.nextSibling)

    super(container, {}, content.width, content.height, true) # Raw, no clipping or compensation

    if content == Layer.main
      @isMain = true
      NavigationViewport.main = this
    else
      @isMain = false

    @setBase(State.fromMatrix(base))

    @inverseViewState = # To convert views to states
      if @isMain
        new State()
      else
        State.fromMatrix(base.multiply(viewportActual))
    @inverseViewState.animationObject = this



  getStateForMaximizedView: (view, centerPage = true) =>
    # TODO If not Main, cache states !

    s = view.viewState.diff(@inverseViewState)
    s.animationObject = this

    # Modify rotate point to be the current translate (corner of the viewport)
    cx = (@inverseViewState.translateX - s.translateX) / svgPageWidth
    cy = (@inverseViewState.translateY - s.translateY) / svgPageHeight
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
      tx = ((view.height * viewportProportions) - view.width) * scaleFactor * @inverseViewState.scaleX / 2
    else
      scaleFactor = scaleHorizontal
      # Center vertically on viewport
      ty = ((view.width / viewportProportions) - view.height) * scaleFactor * @inverseViewState.scaleY / 2

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
      p = NavigationViewport.main.currentState.transformPointInverse(p)

    p = @currentState.transformPointInverse(p)

    normalizeCX = p.x / svgPageWidth
    normalizeCY = p.y / svgPageHeight
    [normalizeCX, normalizeCY]

  translate: (x, y) =>
    p =
      x: x
      y: y

    if not @isMain
      p = NavigationViewport.main.currentState.scaleRotatePointInverse(p)

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
