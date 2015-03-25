class NavigationViewport  extends AnimationObject
  @main: null # Static for the main viewport

  constructor: (content, @viewportAO, @navigation) ->
    viewportEl = @viewportAO.element
    @viewportWidth = getFloatAttr(viewportEl, "width", 0)
    @viewportHeight = getFloatAttr(viewportEl, "height", 0)

    @viewportElement = svgElement("g")

    # Create background
    bg = svgElement("rect")
    @viewportElement.appendChild(bg)
    setAttrs bg,
      x: @viewportAO.origOffset.x
      y: @viewportAO.origOffset.y
      width: @viewportWidth
      height: @viewportHeight
      fill: "rgba(0,0,0,0)" # Transparent
    setTransform(bg, @viewportAO.localOrigMatrix)

    # Clip the content to the viewport
    clipRect = bg.cloneNode(false)
    clip = createClip(clipRect, @viewportElement)
    applyClip(@viewportElement, clip)

    # Create container
    container = svgElement("g")
    $(container).append(content.element)
    @viewportElement.appendChild(container)

    # Insert after viewportElement after original viewportEl
    viewportEl.parentElement.insertBefore(@viewportElement, viewportEl.nextSibling)

    contentDimensions = content.currentDimensions()

    # Raw, no clipping or compensation
    super(container, {}, contentDimensions.width, contentDimensions.height, true)

    if content == Layer.main
      @isMain = true
      NavigationViewport.main = this
      @baseViewState = new State()
    else
      @isMain = false
      @baseViewState = State.fromMatrix(@viewportAO.externalOrigMatrix.inverse().multiply(@viewportAO.actualOrigMatrix))

    @baseViewState.animationObject = this

    @setBase(State.fromMatrix(@viewportAO.externalOrigMatrix.inverse())) # Undo the positioning done by nesting

    @lock = false

    @initUserNavigation()

  initUserNavigation: () =>
    prev = null
    dragging = false
    panning = false

    getTransformedCursor = (e) =>
      cursor =
        x: e.clientX
        y: e.clientY
      @transformPointToCurrent(cursor, true) # exclude own transform

    stopMove = () =>
      dragging = false
      panning = false

    $(@viewportElement)
      .mousemove (e) =>
        if not @lock
          if e.ctrlKey
            if not (dragging or panning)
              prev = getTransformedCursor(e)
            panning = true
          else
            panning = false

          if dragging or panning
            p = getTransformedCursor(e)

            delta =
              x: p.x - prev.x
              y: p.y - prev.y

            adjustedDelta = @baseState.scaleRotatePoint(delta)

            @translate(adjustedDelta)

            @ensureViewportLimits()

            prev = p

            @changeCallback?()

            false

      .mousedown (e) =>
        if not @lock
          prev = getTransformedCursor(e)
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

          centerPoint = @transformPointToCurrent
            x: e.clientX
            y: e.clientY
          center = [centerPoint.x / @width, centerPoint.y / @height]

          if e.altKey # Rotate instead of zoom when Alt is pressed
            rotation = delta * 20
            @rotate(rotation, center)
          else
            scale = 1 + delta
            @scale(scale, center)

          @ensureViewportLimits()

          @changeCallback?()

          false # Avoid zooming on windows if ctrl is pressed

  getViewportCurrentDimensions: () =>
    if @isMain
      width: svgPageCorrectedWidth
      height: svgPageCorrectedHeight
    else
      width: @viewportWidth
      height: @viewportHeight

  getStateForMaximizedView: (view, centerPage = true) =>
    s = @baseViewState.clone()

    # TODO Add some margin as an option on the view object?

    orig = view.currentState.transformPoint(view.compensateDelta)

    viewDimensions = view.currentDimensions()

    s.translateX -= orig.x
    s.translateY -= orig.y

    cx = orig.x / @width
    cy = orig.y / @height
    s.center = [cx, cy]

    s.rotation -= view.currentState.rotation

    viewportDimensions = @getViewportCurrentDimensions()

    viewportProportions = viewportDimensions.width / viewportDimensions.height

    scaleHorizontal = viewportDimensions.width / viewDimensions.width
    scaleVertical = viewportDimensions.height / viewDimensions.height

    scaleFactor = null # Final scale factor
    tx = 0
    ty = 0

    if scaleHorizontal > scaleVertical
      scaleFactor = scaleVertical
      # Center horizontally on viewport
      tx = ((viewDimensions.height * viewportProportions) - viewDimensions.width) * scaleFactor * matrixScaleX(@viewportAO.localOrigMatrix) / 2
    else
      scaleFactor = scaleHorizontal
      # Center vertically on viewport
      ty = ((viewDimensions.width / viewportProportions) - viewDimensions.height) * scaleFactor * matrixScaleY(@viewportAO.localOrigMatrix) / 2

    if @isMain and centerPage
      # Correct page centering on the viewport
      if svgProportions > viewportProportions
        ty -= ((viewportDimensions.height - (viewportDimensions.width / svgProportions)) / 2)
      else
        tx -= ((viewportDimensions.width - (viewportDimensions.height * svgProportions)) / 2)

    s.translateX += tx
    s.translateY += ty

    s.scaleX *= scaleFactor
    s.scaleY *= scaleFactor

    s

  # Get the corners of the viewport represented by this state in content coordinates
  stateToContentPoints: (s) =>
    rel = s.diff(@baseViewState)

    orig = rel.scaleRotatePoint((x: rel.translateX, y: rel.translateY))

    viewportDimensions = @getViewportCurrentDimensions()
    w = viewportDimensions.width * rel.scaleX
    h = viewportDimensions.height * rel.scaleY

    radRotation = toRadians(rel.rotation)
    sin = Math.sin(radRotation)
    cos = Math.cos(radRotation)

    sinW = sin*w
    cosW = cos*w
    sinH = sin*h
    cosH = cos*h

    topLeft: orig
    topRight:
      x: orig.x + cosW
      y: orig.y + sinW
    bottomLeft:
      x: orig.x - sinH
      y: orig.y + cosH
    bottomRight:
      x: orig.x + cosW - sinH
      y: orig.y + sinW + cosH

  ensureViewportLimits: () =>
    points = @stateToContentPoints(@currentState)

    console.log points.topLeft
    console.log points.topRight
    console.log points.bottomLeft
    console.log points.bottomRight
    console.log " "

    # TODO Get points for full state (for now, @baseState)

    # TODO
    # Find minimal corrections to minimize points outside full state
    # It doesn't perform any rotation correction
    # It places a minimum scale limit (avoid on mouse event before it happens)

  parentNavigations: () =>
    if not @parentNavigationsCache?
      @parentNavigationsCache = []
      $(@element).parent().parents(".Navigation").each (idx, e) =>
        n = AnimationObject.byFullName[$(e).data("fullName")]
        @parentNavigationsCache.push n

    @parentNavigationsCache

  transformPointToCurrent: (p, excludeOwn = false, isClient = true) =>
    if isClient
      # Center relative to page
      p.x = (p.x - svgPageOffsetX) / svgPageScale
      p.y = (p.y - svgPageOffsetY) / svgPageScale

    for n, idx in @parentNavigations() by -1

      # Apply navigation transformation
      navDiffState = n.currentState.diff(n.baseState)
      p = navDiffState.transformPoint(p)

      if not excludeOwn or idx > 0 # Ignore own transformation for translate
        p = n.viewport.baseState.transformPoint(p)
        p = n.viewport.currentState.transformPointInverse(p)

    p
