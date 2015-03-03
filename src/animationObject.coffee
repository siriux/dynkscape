class AnimationObject
  constructor: (e, w, h, skipCompensation = false) ->
    @element = e
    @width = w
    @height = h
    @baseState = null
    @currentState = null
    @provisionalState = null

    # To compensate offset of objects inside a group
    if not skipCompensation and e.tagName == "g"
      box = Snap(e).getBBox()
      @delta = # Not delta yet, it will be delta after setBase
        x: box.x
        y: box.y
      @compensateGroup = true
    else
      @compensateGroup = false

  setBase: (state) =>
    state.animationObject = this
    @baseState = state
    @reset()

    if @compensateGroup == true
      @delta.x -= state.translateX
      @delta.y -= state.translateY

  reset: () =>
    @baseState.apply()
    @currentState = @baseState.clone()

  addAction: (a, time) => a.applyTo(@currentState, time)

  apply: () =>
    @currentState.apply()

  addProvisionalAction: (a, time) =>
    if not @provisionalState?
      @provisionalState = @currentState.clone()
    a.applyTo(@provisionalState, time)

  applyProvisional: () =>
    @provisionalState.apply()
    @provisionalState = null
