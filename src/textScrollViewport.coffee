class ScrollTextViewport extends AnimationObject

  constructor: (flowRoot, flowRect, container) ->

    @clipElement = sSvg.g()
    @clipElement.append(container)

    clipRect = flowRect.clone()
    clip = createClip(clipRect, @clipElement)
    applyClip(@clipElement, clip)

    @clipWidth = parseFloat(clipRect.attr("width")) or 0
    @clipHeight = parseFloat(clipRect.attr("height")) or 0

    $(flowRoot).replaceWith(@clipElement.node)

    # Raw, no clipping or compensation
    super(container.node, {}, @clipWidth, @clipWidth, true)

    base = State.fromMatrix(localMatrix(flowRect.node))
    base.translateX += parseFloat(flowRect.attr("x")) or 0
    base.translateY += parseFloat(flowRect.attr("y")) or 0

    @setBase(base)

  recalculate: () =>
    se = Snap(@element)

    @width = parseFloat(se.attr("width")) or 0
    @height = parseFloat(se.attr("height")) or 0

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
