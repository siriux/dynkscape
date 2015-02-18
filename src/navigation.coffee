class Navigation
  constructor: (@parent, contents, userNavigation = true) ->
    @container = sSvg.g().node
    $(@container).append(contents)
    Snap(@parent).append(@container)

    if (userNavigation)
      @initUserNavigation()

  applyMatrix: (m, animate) =>
    # .toTransformString() is needed to be able to animate
    if animate?
      Snap(@container).animate({ transform: m.toTransformString() }, animate.duration, animate.easing)
    else
      Snap(@container).transform(m.toTransformString())

  navigateToElement: (element, animate) =>
    e = Snap(element)

    # TODO gm and am must be read during loading.
    # Afterwards is difficult to remove all transformations. There can be many levels.

    # Window # TODO Viewport on sub panel
    ww = $(window).width()
    wh = $(window).height()
    wProp = ww/wh

    # Element
    ew = e.attr("width")
    eh = e.attr("height")

    # Get element dimensions on screen
    gm = globalMatrix(element)
    elScale = decomposeMatrix(gm).scaleX

    sw = ww / (elScale * ew)
    sh = wh / (elScale * eh)

    s = 1
    tx = 0
    ty = 0

    if sw > sh
      s = sh
      tx = ((eh * wProp) - ew) / 2 # Center horizontally on window
    else
      s = sw
      ty = ((ew / wProp) - eh) / 2 # Center vertically on window

    # TODO Avoid on sub panel
    # Correct page centering on the window
    view = jSvg.attr("viewBox").match(/-?[\d\.]+/g)
    vw = view[2]
    vh = view[3]
    vProp = vw/vh

    if vProp > wProp
      ty -= ((wh - (ww / vProp)) / 2) / (s*elScale)
    else
      tx -= ((ww - (wh * vProp)) / 2) / (s*elScale)

    am = actualMatrix(element).invert()

    finalMatrix = new Snap.Matrix()
      .scale(s, s)
      .translate(tx,ty)
      .add(am)

    @applyMatrix(finalMatrix, animate)

  initUserNavigation: () ->
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

    $(@parent)
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
          @applyMatrix(newM)
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
        scale = 1 + delta

        updateTransformMatrix()
        p = getTransformedFromEvent(e)

        # Ideas from
        # http://www.cyberz.org/projects/SVGPan/SVGPan.js
        newM = localMatrix(@container)
          .translate(p.x, p.y)
          .scale(scale)
          .translate(-p.x, -p.y)
        @applyMatrix(newM)

        false # Avoid zooming on windows if ctrl is pressed


createNavigationForLayer = (layerName, parent, viewportElementId, userNavigation = true) ->
  l = Snap(inkscapeLayersByName[layerName].element)
  viewEl = Snap("##{viewportElementId}")

  viewportGroup = Snap(parent).g()

  # Create group background
  bg = viewportGroup.rect(0,0,viewEl.attr("width"),viewEl.attr("height"))
  bg.attr
    fill: "rgba(0,0,0,0)" # Transparent
    transform: actualMatrix(viewEl) # TODO Remove transformations of parent? Is needed?

  # Clip the layer to the viewport
  clip = Snap(svgElement("clipPath"))
  clip.append(bg.clone())
  clip.attr(id: clip.id)
  viewportGroup.append(clip)
  viewportGroup.attr("clip-path": "url(##{clip.id})")

  new Navigation(viewportGroup.node, l.node, userNavigation)
