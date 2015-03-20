class NavigationViewport  extends AnimationObject
  @main: null # Static for the main viewport

  constructor: (content, @viewportAO, @navigation) ->
    viewportEl = @viewportAO.element

    @viewportElement = svgElement("g")

    # Create background
    bg = svgElement("rect")
    @viewportElement.appendChild(bg)
    setAttrs bg,
      x: @viewportAO.origX
      y: @viewportAO.origY
      width: getFloatAttr(viewportEl, "width")
      height: getFloatAttr(viewportEl, "height")
      fill: "rgba(0,0,0,0)" # Transparent
    setTransform(bg, @viewportAO.localOrigMatrix)

    # Clip the content to the viewport
    clipRect = bg.cloneNode(false)
    clip = createClip(clipRect, @viewportElement)
    #applyClip(@viewportElement, clip)
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

    @setBase(State.fromMatrix(@viewportAO.externalOrigMatrix.inverse())) # Undo the positioning done by nesting

  getStateForMaximizedView: (view, centerPage = true) =>
    viewDiff = view.actualOrigMatrix
    base = @viewportAO.externalOrigMatrix.inverse().multiply(@viewportAO.actualOrigMatrix)
    s = State.fromMatrix(base.multiply(viewDiff.inverse()))
    s.animationObject = this

    # Modify rotate point to be the current translate (corner of the viewport)
    cx = (@viewportAO.origX - s.translateX) / @width
    cy = (@viewportAO.origY - s.translateY) / @height
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
      tx = ((view.height * viewportProportions) - view.width) * scaleFactor * matrixScaleX(@viewportAO.localOrigMatrix) / 2
    else
      scaleFactor = scaleHorizontal
      # Center vertically on viewport
      ty = ((view.width / viewportProportions) - view.height) * scaleFactor * matrixScaleY(@viewportAO.localOrigMatrix) / 2

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

  _parentNavigations: () =>
    if not @_parentNavigationsCache?
      @_parentNavigationsCache = []
      $(@element).parent().parents(".Navigation").each (idx, e) =>
        n = AnimationObject.byFullName[$(e).data("fullName")]
        @_parentNavigationsCache.push n

    @_parentNavigationsCache

  transformPointToCurrent: (p, excludeOwn = false, isClient = true) =>
    if isClient
      # Center relative to page
      p.x = (p.x - svgPageOffsetX) / svgPageScale
      p.y = (p.y - svgPageOffsetY) / svgPageScale

    for n, idx in @_parentNavigations() by -1

      # Apply navigation transformation
      navDiffState = n.currentState.diff(n.baseState)
      p = navDiffState.transformPoint(p)

      if not excludeOwn or idx > 0 # Ignore own transformation for translate
        p = n.viewport.baseState.transformPoint(p)
        p = n.viewport.currentState.transformPointInverse(p)

    p

  _getCenterPoint: (p) =>
    normalizeCX = p.x / @width
    normalizeCY = p.y / @height
    [normalizeCX, normalizeCY]

  translate: (p) =>
    s = @currentState
    s.translateX += p.x
    s.translateY += p.y
    s.apply()

  scale: (scale, center) =>
    s = @currentState

    s.changeCenter(@_getCenterPoint(center))

    s.scaleX *= scale
    s.scaleY *= scale

    s.changeCenter([0, 0])

    s.apply()

  rotate: (rotation, center) =>
    s = @currentState

    s.changeCenter(@_getCenterPoint(center))

    s.rotation += rotation

    s.changeCenter([0, 0])

    s.apply()
