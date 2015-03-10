class TextScroll extends AnimationObject

  @byName: {}

  constructor: (element, meta) ->
    super(element)

    flowRoot = $(@element).find("flowRoot")[0]

    @scroll = 0

    @name = if meta.textScroll.name? then meta.textScroll.name else Snap(@element).attr("id")
    TextScroll.byName[@name] = this

    # Viewport

    @viewport = sSvg.g()

    rect = Snap(flowRoot).select("flowRegion > rect")

    @_viewportX = rect.attr("x")
    @_viewportY = rect.attr("y")
    @_viewportWidth = rect.attr("width")
    @_viewportHeight = rect.attr("height")

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
      width: @_viewportWidth
      height: @_viewportHeight # Provide temporal height to allow real calculations inside

    @viewport.append(@container)

    # TODO Add visual hints to scroll (shadows at the top/bottom?)

    # Text Content

    rawText = $.makeArray($(flowRoot).find("flowPara"))
      .map((p) -> $(p).text())
      .join("\n")

    rederedText =
      if meta.textScroll.process == "markdown"
        # TODO Process links if needed
        marked(rawText)
      else
        rawText

    @textContent = $(htmlElement("div"))

    align = if meta.textScroll.align? then meta.textScroll.align else "justify"
    padding = if meta.textScroll.padding? then meta.textScroll.padding else 20

    @textContent
      .css
        width: @_viewportWidth - padding*2 # Set the width, so that paragraphs can expand
        padding: "#{padding}px"
        "text-align": align
      .html(rederedText)

    @container.append(@textContent[0])

    # Set the real size of the @container to it's content size

    containerHeight = @textContent.height() + padding*2
    @container.attr(height: containerHeight)

    @maxScroll = Math.max(0, containerHeight - @_viewportHeight)

    # Raw, it's internal object
    @animationObject = new AnimationObject(@container.node, @_viewportWidth, containerHeight, true)
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

    # Process Anchors
    @anchors = {}

    @textContent.css(position: "relative") # Needed to get the right offsetTop

    @textContent.find("a[name]").each (idx, anchor) =>
      name = $(anchor).attr("name")
      @anchors[name] = anchor.offsetTop - padding # Substract padding for a little extra space

    @textContent.css(position: "static") # Revert to default

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
    @animationObject.applyCurrent()

  updateScroll: (delta) => @setScroll(@scroll + delta)

  goToAnchor: (name) =>
    # TODO Animation?
    anchorScroll = @anchors[name]
    if anchorScroll?
      @setScroll(anchorScroll)
