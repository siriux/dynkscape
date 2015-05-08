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

    contentExternalMatrix = content.externalOrigMatrix # Undo content positioning (like offset in layers)
    viewportExternalMatrixInv = @viewportAO.externalOrigMatrix.inverse() # Undo the positioning done by nesting
    correctedBaseMatrix = viewportExternalMatrixInv.multiply(contentExternalMatrix)
    @setBase(State.fromMatrix(correctedBaseMatrix))

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

          @changeCallback?()

          false # Avoid zooming on windows if ctrl is pressed

  transformCurrent: (center, f) =>
    s = @currentState

    if center?
      origCenter = s.center
      s.changeCenter(center)

    f(s)

    if center?
      s.changeCenter(origCenter)

    @applyViewportLimits()

    s.apply()

  translate: (p) =>
    @transformCurrent null, (s) ->
      s.translateX += p.x
      s.translateY += p.y

  scale: (scale, center) =>
    @transformCurrent center, (s) ->
      s.scaleX *= scale
      s.scaleY *= scale

  rotate: (rotation, center) =>
    @transformCurrent center, (s) ->
      s.rotation += rotation

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
  stateToContentRect: (s) =>
    rel = s.diff(@baseViewState)

    orig = rel.scaleRotatePoint((x: rel.translateX, y: rel.translateY))

    viewportDimensions = @getViewportCurrentDimensions()
    w = viewportDimensions.width * rel.scaleX
    h = viewportDimensions.height * rel.scaleY

    # TODO Optimize for rel.rotation = 0
    radRotation = toRadians(rel.rotation)
    sin = Math.sin(radRotation)
    cos = Math.cos(radRotation)

    sinW = sin*w
    cosW = cos*w
    sinH = sin*h
    cosH = cos*h

    points: [ # Ordered clockwise, starting by original top-left corner
      orig
      { x: orig.x + cosW, y: orig.y + sinW }
      { x: orig.x + cosW - sinH, y: orig.y + sinW + cosH }
      { x: orig.x - sinH, y: orig.y + cosH }
    ]
    width: w
    height: h

  applyViewportLimits: () =>
    # It just transforms position, no rotation or scale is performed
    # If limits cannot be applied, it tries to adjust as much as possible
    # Other limits should be applied elsewhere, like limiting minimum zoom

    # Positive and negative deltas, horizontally and vertically in limits coordinates
    neededPosH = neededNegH = neededPosV = neededNegV = 0
    allowedPosH = allowedPosV = Number.POSITIVE_INFINITY
    allowedNegH = allowedNegV = Number.NEGATIVE_INFINITY

    current = @stateToContentRect(@currentState)

    # TODO Get points for full state (for now, @baseState) and cache
    limits = @stateToContentRect(@baseState)

    for i in [0..3]
      # Side start and end
      a = limits.points[i]
      b = limits.points[(i + 1) % 4]

      sideLength = if i % 2 == 0 then limits.width else limits.height

      # Reuse ba vector
      baX = b.x - a.x
      baY = b.y - a.y

      for c in current.points
        # Cross product module of ba x ca
        z = baX * (c.y - a.y) - baY * (c.x - a.x)

        dist = Math.abs(z / sideLength) # z = |ba|*|ca|*sin, and we need |ca|*sin

        if z < 0
          # c outside of the rect with respect to side ab
          switch i
            when 0 then if dist > neededPosV then neededPosV = dist
            when 1 then if -dist < neededNegH then neededNegH = -dist
            when 2 then if -dist < neededNegV then neededNegV = -dist
            when 3 then if dist > neededPosH then neededPosH = dist
        else
          # c inside of the rect with respect to side ab
          switch i
            when 0 then if -dist > allowedNegV then allowedNegV = -dist
            when 1 then if dist < allowedPosH then allowedPosH = dist
            when 2 then if dist < allowedPosV then allowedPosV = dist
            when 3 then if -dist > allowedNegH then allowedNegH = -dist

    dh =
      if neededPosH == 0
        neededNegH
      else if neededNegH == 0
        neededPosH
      else
        (neededPosH + neededNegH) / 2

    if dh < 0 && dh < allowedNegH
      dh = ((dh - allowedNegH) / 2) + allowedNegH
    else if dh > 0 && dh > allowedPosH
      dh = ((dh - allowedPosH) / 2) + allowedPosH

    dv =
      if neededPosV == 0
        neededNegV
      else if neededNegV == 0
        neededPosV
      else
        (neededPosV + neededNegV) / 2

    if dv < 0 && dv < allowedNegV
      dv = ((dv - allowedNegV) / 2) + allowedNegV
    else if dv > 0 && dv > allowedPosV
      dv = ((dv - allowedPosV) / 2) + allowedPosV

    # Unit vectors in limit coordinates
    unitHX = (limits.points[1].x - limits.points[0].x) / limits.width
    unitHY = (limits.points[1].y - limits.points[0].y) / limits.width

    unitVX = (limits.points[2].x - limits.points[1].x) / limits.height
    unitVY = (limits.points[2].y - limits.points[1].y) / limits.height

    # Final vector in content coordinates
    dx = unitHX*dh + unitVX*dv
    dy = unitHY*dh + unitVY*dv

    # Scaling and rotating is needed because we work in content coordinates!
    correction = @currentState.scaleRotatePoint((x: dx, y: dy))
    @currentState.translateX -= correction.x
    @currentState.translateY -= correction.y

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
