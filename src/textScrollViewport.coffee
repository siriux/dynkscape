class ScrollTextViewport extends AnimationObject

  constructor: (flowRoot, flowRect, container) ->

    @clipElement = svgElement("g")
    @clipElement.appendChild(container)

    clipRect = flowRect.cloneNode(false)
    clip = createClip(clipRect, @clipElement)
    applyClip(@clipElement, clip)

    @clipWidth = getFloatAttr(clipRect, "width", 0)
    @clipHeight = getFloatAttr(clipRect, "height", 0)

    $(flowRoot).replaceWith(@clipElement)

    # Raw, no clipping or compensation
    super(container, {}, @clipWidth, @clipWidth, true)

    base = State.fromMatrix(localMatrix(flowRect))
    base.translateX += getFloatAttr(flowRect, "x", 0)
    base.translateY += getFloatAttr(flowRect, "y", 0)

    @setBase(base)

  recalculate: () =>
    @width = getFloatAttr(@element, "width", 0)
    @height = getFloatAttr(@element, "height", 0)

    @maxScroll = Math.max(0, @height - @clipHeight)

  currentScroll: () => @baseState.translateY - @currentState.translateY

  getStateForScroll: (s) =>
    if s < 0
      s = 0
    else if s > @maxScroll
      s = @maxScroll

    state = @baseState.clone()
    state.translateY -= s

    state

  setScroll: (s) =>
    @currentState = @getStateForScroll(s)
    @applyCurrent()

  updateScroll: (delta) => @setScroll(@currentScroll() + delta)
