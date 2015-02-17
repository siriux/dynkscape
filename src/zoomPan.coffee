initZoomPan = () ->

  layerElements = (l.element for l in inkscapeLayers)

  container = sSvg.g()

  $(container.node).append(layerElements)

  # Drag
  m = null
  prevX = 0
  prevY = 0
  dragging = false
  initPending = false

  transformMatrix = null

  getTransformedFromEvent = (e) ->
    # Ideas from
    # http://svg.dabbles.info/snaptut-create-slider-knob.html
    p = container.node.ownerSVGElement.createSVGPoint()
    p.x = e.clientX
    p.y = e.clientY
    p.matrixTransform(transformMatrix)

  updateTransformMatrix = () ->
    transformMatrix = container.node.getScreenCTM().inverse()

  initDrag = (e) ->
    m = localMatrix(container)
    updateTransformMatrix()
    p = getTransformedFromEvent(e)
    prevX = p.x
    prevY = p.y
    dragging = true
    initPending = false

  $("svg")
    .mousemove (e) ->
      if initPending or (not dragging and e.ctrlKey)
        initDrag(e)

      if dragging
        p = getTransformedFromEvent(e) # Don't update the matrix !!
        newM = m.clone().translate(p.x - prevX, p.y - prevY)
        container.transform(newM)

    .mousedown (e) ->
      initDrag(e)
      false # Avoid selection

    .mouseup (e) ->
      dragging = false

    .mouseleave (e) ->
      dragging = false

    .keydown (e) ->
      if e.ctrlKey
        initPending = true
        dragging = true

    .keyup (e) ->
      if not e.ctrlKey
        initPending = false
        dragging = false

    .on "mousewheel", (e) ->
      dragging = false # stop any pending pan

      delta = e.originalEvent.deltaY
      scale = 1 + (delta / 100)

      updateTransformMatrix()
      p = getTransformedFromEvent(e)

      # Ideas from
      # http://www.cyberz.org/projects/SVGPan/SVGPan.js
      newM = localMatrix(container)
        .translate(p.x, p.y)
        .scale(scale)
        .translate(-p.x, -p.y)
      container.transform(newM)
