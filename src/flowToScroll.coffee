flowToScroll = (flowRoot) ->

  # Create viewport

  rect = Snap(flowRoot).select("flowRegion > rect")

  x = rect.attr("x")
  y = rect.attr("y")
  width = rect.attr("width")
  height = rect.attr("height")
  transform = $(flowRoot).attr("transform")

  viewport = sSvg.paper.svg(x,y,width,height)
  viewportGroup = sSvg.paper.g(viewport)
  viewportGroup.transform(transform)

  $(flowRoot).replaceWith(viewportGroup.node)

  # Create foreignObject

  fO = Snap(svgElement("foreignObject"))

  fO.attr
    width: width
    height: height # Provide temporal height to allow real calculations inseide

  viewport.append(fO)

  # Process Markdown

  mkText = $.makeArray($(flowRoot).find("flowPara"))
    .map((p) -> $(p).text())
    .join("\n")

  tree = markdown.parse(mkText)

  # TODO Process links if needed

  rederedText = markdown.renderJsonML(markdown.toHTMLTree(tree))

  textContainer = $(htmlElement("div"))

  textContainer
    .width(width) # Set the width, so that paragraphs can expand
    .css("text-align", "justify")

  textContainer.html(rederedText)

  fO.append(textContainer[0])

  # Set the real size of the foreignObject to it's content size

  contentHeight = textContainer.height()
  fO.attr(height: contentHeight)

  # Add scroll on foreignObject

  # TODO Adapt scaleFactor to rotation !!!
  scaleFactor = decomposeMatrix(globalMatrix(viewportGroup)).scaleY
  matrix = localMatrix(fO)
  scroll = 0
  maxScroll = contentHeight - height
  maxScroll = 0 if maxScroll < 0

  updateScroll = (delta) ->
    scroll += delta
    scroll = 0 if (scroll < 0)
    scroll = maxScroll if (scroll > maxScroll)

    matrix.f = -scroll
    fO.transform(matrix)

  # Drag
  prevY = null
  dragging = false
  $(fO.node)
    .mousemove (e) ->
      prevY ?= e.clientY
      if dragging
        delta = (e.clientY - prevY) / scaleFactor
        prevY = e.clientY
        updateScroll(-delta)
        false
    .mousedown (e) ->
      prevY = e.clientY
      dragging = true
      false
    .mouseup (e) ->
      dragging = false
      false
    .mouseleave (e) ->
      dragging = false
      false

  # Scroll
  textContainer.on "mousewheel", (e) ->
    if (not e.ctrlKey) # With ctrl pressed, allow to zoom
      updateScroll(e.originalEvent.deltaY) # For scroll in mac, otherwise, invert
      false
