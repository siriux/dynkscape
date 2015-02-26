class AnimationObject
  constructor: (e, w, h) ->
    @element = e
    @width = w
    @height = h
    @baseState = null
    @currentState = null
    @provisionalState = null

  setBase: (state) =>
    state.animationObject = this
    @baseState = state
    @reset()

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
