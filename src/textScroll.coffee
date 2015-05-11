class TextScroll extends AnimationObject

  constructor: (element, meta) ->
    super(element, meta, null, null, true)

    @setBase(State.fromMatrix(localMatrix(@element)))

    flowRoot = $(@element).find("flowRoot")[0]

    flowRect = $(flowRoot).find("flowRegion > rect")[0]

    setTransform(flowRect, getStringAttr(flowRoot, "transform"))

    flowWidth = getFloatAttr(flowRect, "width", 0)
    flowHeight = getFloatAttr(flowRect, "height", 0)

    @scroll = 0

    # ForeignObject

    container = svgElement("foreignObject")

    setAttrs container,
      width: flowWidth
      height: flowHeight # Provide temporal height to allow real calculations inside

    # TODO Add visual hints to scroll (shadows at the top/bottom?)

    # Text Content

    rawText = [].slice.call($(flowRoot).find("flowPara"))
      .map((p) -> $(p).text())
      .join("\n")

    rederedText =
      if meta.textScroll.process == "markdown"

        # Process links
        @animations ?= []
        renderer = new marked.Renderer()
        animCount = 0
        renderer.link = (href, title, text) =>
          title ?= ""

          if href.charAt(0) == "@"
            animDesc = MetaParser.parseAnimation(href)[0]
            name = animDesc[0].__positionals[0][1..]
            if name == ""
              name = "link#{animCount}"
            a = new Animation(animDesc, @fullname, name)
            @animations.push a
            animCount += 1
            """
            <span
              style=\"font-weight: bold; cursor: pointer; text-decoration: underline\"
              title=\"#{title}\"
              onclick=\"Animation.byFullName['#{a.fullName}'].play()\"
            >#{text}</span>
            """
          else
            "<a href=\"#{href}\" target=\"_blank\" title=\"#{title}\">#{text}</a>"

        marked(rawText, renderer: renderer)
      else
        rawText

    @textContent = htmlElement("div")

    align = if meta.textScroll.align? then meta.textScroll.align else "justify"
    padding = if meta.textScroll.padding? then meta.textScroll.padding else 20

    setStyle @textContent,
      width: flowWidth - padding*2 # Set the width, so that paragraphs can expand
      padding: "#{padding}px"
      "text-align": align

    @textContent.innerHTML = rederedText

    container.appendChild(@textContent)

    svgNode.appendChild(container) # We need the content on the DOM to get clientHeight

    # Set the real size of the container to it's content size
    containerHeight = @textContent.clientHeight
    container.setAttribute("height", containerHeight)

    # Viewport animation object needed by the viewport
    $(flowRect).hide().appendTo(@element) # Hide it, as it's not needed. Deleting it after creating the object would probably work, but can give problems
    viewportAO = new AnimationObject(flowRect, {namespace: @fullName, name: "viewport"}, flowWidth, flowHeight, true)

    # Transform container to it's aparent initial size, equivalent to what you would view on the editor
    # This is needed by the viewport, that also works with normal objects
    setTransform(container, viewportAO.actualOrigMatrix)

    # Container animation object needed by the viewport
    containerAO = new AnimationObject(container, {namespace: @fullName, name: "text"})

    @viewport = new NavigationViewport(containerAO, viewportAO, 1, 2)
    @viewport.changeCallback = () => @updateReferenceState()

    # Process Anchors
    @anchors = {}

    t = $(@textContent)
    currentTextOffset = t.offset()
    currentTextScale = containerHeight / currentTextOffset.height
    t.find("a[name]").each (idx, anchor) =>
      name = getStringAttr(anchor, "name")
      anchorScroll = ($(anchor).offset().top - currentTextOffset.top) * currentTextScale
      @anchors[name] = anchorScroll - padding

  getScroll: () => @viewport.baseState.translateY - @viewport.currentState.translateY

  setScroll: (scroll) =>
    @viewport.currentState.translateY = @viewport.baseState.translateY - scroll
    @viewport.applyViewportLimits()
    @viewport.currentState.apply()


  goToAnchor: (name) =>
    # TODO Animation?

    anchorScroll = @anchors[name]
    if anchorScroll?
      @setScroll(anchorScroll)

  saveReferenceState: () =>
    newReferenceState(@reference)

  updateReferenceState: () =>
    updateReferenceState @reference, (s) => s.scroll = @getScroll()

  applyReferenceState: (s, skipAnimation = false) =>
    if s.scroll?
      @setScroll(s.scroll)
