class ActionDesc

  @register: (a) ->

    # TODO

    Action.descs[a.name] =
      init: a.init
      processPositionals: null

      toLongNames: null

      setDefaults: null

      singleStart: null

      singleEnd: null

class Action

  @actionNames: []

  @descs: {}

  constructor: (@name, @vars) ->
    @time = @vars.time
    @desc = Action.descs[@name]
    @desc.init?(@vars) # It can modify or define new vars

  singleStart: () => @desc.singleStart?(@vars)

  singleEnd: () => @desc.singleEnd?(@vars)

  exec: (time) =>
    offset = time - @context.time
    rawDelta = Math.min(Math.max(offset / @context.duration, 0), 1)

    if 0 < rawDelta < 1
      delta = getEasing(@context.easing)(rawDelta)
    else
      delta = rawDelta

    # TODO Calculate if the action has ended

    # TODO
    # We have to handle state clonning in the action, if needed.
    # For Action objects, use provisional and current.
    # Apply the action to current if ended.
    # Keep track of provisionals (argument?) and make sure they are applied !!!!

ActionDesc.register
  name: "foo"
  init: (vars) ->
    vars.duration = 0 # Here we can force duration for external actions
  arguments: [
    ["translateX", "tx"]  # Name, short and optionally default
    ["scale", null, 3]    # If short is missing, but want default
    "rotate"              # Only long name without default
  ]
  defaultContext:
    duration: 1.5
  exec: (vars, delta, rawDelta, last) ->

    ###
    # If state center is not the right one, change it before applying
    if state.center[0] != @context.center[0] or state.center[1] != @context.center[1]
      state.changeCenter(@context.center)

    if @translateX?
      state.translateX += @translateX * delta

    if @translateY?
      state.translateY += @translateY * delta

    diffScaleX = (state.scaleX * @scaleX) - state.scaleX
    if @scaleX?
      state.scaleX += diffScaleX * delta

    diffScaleY = (state.scaleY * @scaleY) - state.scaleY
    if @scaleY?
      state.scaleY += diffScaleY * delta

    if @rotation?
      state.rotation += @rotation * delta

    if @opacity?
      state.opacity = @opacity * delta

    if @effect?
      applyEffect(@effect, this, state, delta, rawDelta)
    ###
