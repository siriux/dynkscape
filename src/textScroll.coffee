class TextScroll extends AnimationObject

  constructor: (element, meta) ->
    super(element, meta)

    flowRoot = $(@element).find("flowRoot")[0]

    flowRect = Snap(flowRoot).select("flowRegion > rect")

    flowRect.attr(transform: $(flowRoot).attr("transform"))

    flowWidth = parseFloat(flowRect.attr("width")) or 0
    flowHeight = parseFloat(flowRect.attr("height")) or 0

    @scroll = 0

    # ForeignObject

    @container = Snap(svgElement("foreignObject"))

    @container.attr
      width: flowWidth
      height: flowHeight # Provide temporal height to allow real calculations inside

    @viewport = new ScrollTextViewport(flowRoot, flowRect, @container)

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
        width: flowWidth - padding*2 # Set the width, so that paragraphs can expand
        padding: "#{padding}px"
        "text-align": align
      .html(rederedText)

    @container.append(@textContent[0])

    # Set the real size of the @container to it's content size

    containerHeight = @textContent.height() + padding*2
    @container.attr(height: containerHeight)

    @viewport.recalculate()

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
        if dragging
          # TODO Adapt scaleFactor to rotation !!!
          # TODO See how it's done for Navigation and NavigationViewport
          scaleFactor = matrixScaleY(globalMatrix(@viewport.element))
          
          prevY ?= e.clientY

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
    @viewport.setScroll(s)

  updateScroll: (delta) => @viewport.updateScroll(delta)

  goToAnchor: (name) =>
    # TODO Animation?
    anchorScroll = @anchors[name]
    if anchorScroll?
      @setScroll(anchorScroll)