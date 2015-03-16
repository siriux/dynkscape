class ActionDesc

  @register: (a) ->
    desc =
      init: a.init
      processPositionals: (side, vars) ->
        for arg in a.arguments
          value = side.__positionals?.shift()
          if value?
            vars[arg[0]] = value
          else
            break;

      toLongNames: (vars) ->
        for arg in a.arguments
          short = arg[1]
          if vars[short]?
            vars[arg[0]] = vars[short]
            delete vars[short]

      setDefaults: (vars) ->
        for arg in a.arguments
          vars[arg[0]] ?= arg[2]

        for k,v of a.defaultContext
          vars[k] ?= v

      singleStart: a.singleStart

      singleEnd: a.singleEnd

      exec: a.exec

    if a.name instanceof Array
      for name in a.name
        Action.descs[name] = desc
        Action.actionNames.add(name)
    else
      Action.descs[a.name] = desc
      Action.actionNames.add(a.name)

  @applyOnStateHelper: (target, last, f) ->
    f(target.getProvisional())

    if last
      f(target.currentState)

    target

class Action

  @actionNames: new Set()

  @descs: {}

  constructor: (@name, @vars) ->
    @desc = Action.descs[@name]
    @desc.init?(@vars) # It can modify or define new vars
    @time = @vars.time
    @duration = @vars.duration

  singleStart: () => @desc.singleStart?(@vars)

  singleEnd: () => @desc.singleEnd?(@vars)

  exec: (time) =>
    offset = time - @time
    rawDelta = Math.min(Math.max(offset / @duration, 0), 1)

    if 0 < rawDelta < 1
      delta = getEasing(@vars.easing)(rawDelta)
    else
      delta = rawDelta

    last = time >= (@time + @duration)

    @desc.exec(@vars, delta, rawDelta, last)

  getAnim: (onEnd) =>
    time = 0

    @time ?= 0

    advanceTime = (delta) =>
      time += delta
      ao = @exec(time)
      ao.applyProvisional()

    new BaseAnimation(@vars.duration, advanceTime, onEnd)
