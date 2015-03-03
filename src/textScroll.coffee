class TextScroll

  constructor: (flowRoot, meta) ->

    @scroll = 0

    # Viewport

    @viewport = sSvg.g()

    rect = Snap(flowRoot).select("flowRegion > rect")

    @x = rect.attr("x")
    @y = rect.attr("y")
    @width = rect.attr("width")
    @height = rect.attr("height")

    rect.attr(transform: $(flowRoot).attr("transform"))
    moveCoordsToMatrix(rect.node)

    clip = Snap(svgElement("clipPath"))
    clipRect = rect.clone()
    clip.append(clipRect)
    clip.attr(id: clip.id)
    @viewport.append(clip)
    @viewport.attr("clip-path": "url(##{clip.id})")

    $(flowRoot).replaceWith(@viewport.node)

    # ForeignObject

    @container = Snap(svgElement("foreignObject"))

    @container.attr
      width: @width
      height: @height # Provide temporal height to allow real calculations inside

    @viewport.append(@container)

    # Text Content

    rawText = $.makeArray($(flowRoot).find("flowPara"))
      .map((p) -> $(p).text())
      .join("\n")

    rederedText =
      if meta.textScroll.process == "markdown"
        tree = markdown.parse(rawText)

        # TODO Process links if needed

        markdown.renderJsonML(markdown.toHTMLTree(tree))
      else
        rawText

    @textContent = $(htmlElement("div"))

    align = if meta.textScroll.align? then meta.textScroll.align else "justify"

    @textContent
      .width(@width) # Set the width, so that paragraphs can expand
      .css("text-align", align)
      .html(rederedText)

    @container.append(@textContent[0])

    # Set the real size of the @container to it's content size

    containerHeight = @textContent.height()
    @container.attr(height: containerHeight)

    @maxScroll = Math.max(0, containerHeight - @height)

    # Animation object

    @animationObject = new AnimationObject(@container.node, @width, containerHeight)
    @animationObject.setBase(State.fromMatrix(localMatrix(rect)))

    # Scroll

    @textContent.on "mousewheel wheel", (e) =>
      if (not e.ctrlKey) # With ctrl pressed, allow to zoom
        delta = e.originalEvent.wheelDelta || e.originalEvent.deltaY
        # Negative to simulate mac natural scroll on chrome
        # TODO Improve for other browsers
        @updateScroll(-delta)
        false

    # Drag

    prevY = null
    dragging = false

    @textContent
      .mousemove (e) =>
        # TODO Adapt scaleFactor to rotation !!!
        # TODO See how it's done for Navigation and Viewport
        scaleFactor = matrixScaleY(globalMatrix(@viewport))

        prevY ?= e.clientY

        if dragging
          delta = (e.clientY - prevY) / scaleFactor
          prevY = e.clientY
          @updateScroll(-delta)
          false
      .mousedown (e) =>
        prevY = e.clientY
        dragging = true
        false
      .mouseup (e) =>
        dragging = false
        false
      .mouseleave (e) =>
        dragging = false
        false

  setScroll: (s) =>
    if s < 0
      @scroll = 0
    else if s > @maxScroll
      @scroll = @maxScroll
    else
      @scroll = s

    state = @animationObject.baseState.clone()

    state.translateY -= @scroll

    @animationObject.currentState = state
    @animationObject.apply()

  updateScroll: (delta) => @setScroll(@scroll + delta)
