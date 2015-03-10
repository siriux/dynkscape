class AnimationObject
  constructor: (@element, w, h, raw = false) ->
    se = Snap(@element)
    box = se.getBBox()

    if not (w? and h?)
      w = parseFloat(se.attr("width"))
      h = parseFloat(se.attr("height"))
      if isNaN(w) or isNaN(h)
        w = box.w
        h = box.h

    @width = w
    @height = h

    @baseState = null
    @currentState = null
    @provisionalState = null

    # Raw AnimationObjects dont compensate, cannot be used as clipping or view, ...
    if not raw
      # To be used as a view in navigations
      @viewState = State.fromMatrix(actualMatrix(@element))

      # Set base state
      m = moveCoordsToMatrix(@element)
      s = State.fromMatrix(m)
      s.opacity = $(@element).css("opacity")
      s.animationObject = this
      s.changeCenter([0.5, 0.5]) # fromMatrix has de wrong default center
      @setBase(s)

      # To compensate offset of objects inside a group
      @compensateDelta =
        x: box.x - s.translateX
        y: box.y - s.translateY

      # Wrap in a group
      @origElement = @element
      group = sSvg.g()
      $(@element).replaceWith(group.node)
      group.append(@element)
      group.attr(transform: m)
      se.attr(transform: "")
      @element = group.node

      # Add clipPath
      clip = Snap(svgElement("clipPath"))
      use = Snap(svgElement("use"))

      oe = Snap(@origElement)
      oe.attr(id: oe.id)
      use.attr("xlink:href": oe.id)

      clip.append(use)
      clip.attr(id: clip.id)
      group.append(clip)

  setBase: (state) =>
    state.animationObject = this
    @baseState = state
    @resetState()

  resetState: () =>
    @baseState.apply()
    @currentState = @baseState.clone()

  addAction: (a, time) => a.applyTo(@currentState, time)

  applyCurrent: () =>
    @currentState.apply()

  addProvisionalAction: (a, time) =>
    if not @provisionalState?
      @provisionalState = @currentState.clone()
    a.applyTo(@provisionalState, time)

  applyProvisional: () =>
    @provisionalState.apply()
    @provisionalState = null
