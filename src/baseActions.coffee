###
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

ActionDesc.register
  name: ["transform", "trf", "alter"] # TODO Think about a good one

  arguments: [
    ["translateX", "tx"]
    ["translateY", "ty"]
    ["scale", "s"]
    ["rotate", "r"]
    ["scaleX", "sx"] # After rotate to allow sensible positionals
    ["scaleY", "sy"]
    ["path"]
    ["range"]
  ]

  init: (vars) ->
    if vars.path?
      if vars.range?
        range = vars.range.split(",")
        vars.pathRangeInfo = vars.path.getRangeInfo([parseInt(range[0]),parseInt(range[1])])
      else
        vars.pathRangeInfo = vars.path.wholeRangeInfo()

  exec: (vars, delta, rawDelta, last) ->

    vars.scaleX ?= vars.scale
    vars.scaleY ?= vars.scale

    ActionDesc.applyOnStateHelper vars.target, last, (state) ->
      state.changeCenter(vars.center)

      if vars.translateX?
        state.translateX += vars.translateX * delta

      if vars.translateY?
        state.translateY += vars.translateY * delta

      if vars.scaleX?
        diffScaleX = (state.scaleX * vars.scaleX) - state.scaleX
        state.scaleX += diffScaleX * delta

      if vars.scaleY?
        diffScaleY = (state.scaleY * vars.scaleY) - state.scaleY
        state.scaleY += diffScaleY * delta

      if vars.rotate?
        state.rotation += vars.rotate * delta

      if vars.path?
        t = vars.path.getTransform(delta, vars.pathRangeInfo)
        state.translateX += t.x
        state.translateY += t.y
        # TODO rotate and scale

ActionDesc.register
  name: "hide"

  arguments: [
    ["effect", null, "fade"]
  ]

  defaultContext:
    duration: 0.5
    easing: "in"

  exec: (vars, delta, rawDelta, last) ->
    ActionDesc.applyOnStateHelper vars.target, last, (state) ->
      switch vars.effect
        when "fade"
          state.opacity = 1 - delta
        when "slide"
          if 0 < delta < 1 # Avoid affecting it outside of the effect
            state.translateX += state.width() * delta
          state.opacity = 1 - delta
        when "scale"
          if 0 < delta < 1 # Avoid affecting it outside of the effect
            state.scaleX *= 1 + delta
            state.scaleY *= 1 + delta
          state.opacity = 1 - delta

ActionDesc.register
  name: "attention"

  arguments: [
    ["effect", null, "shake"]
    ["amplitude", null, 0.05] # Amplitude in units of the target width
  ]

  defaultContext:
    duration: 0.5
    easing: "inout"

  exec: (vars, delta, rawDelta, last) ->
    ActionDesc.applyOnStateHelper vars.target, last, (state) ->
      switch vars.effect
        when "shake"
          if 0 < delta < 1 # Avoid affecting it outside of the effect
            times = 4 * 4 # each shake it's divided in 4 steps
            displacement = state.width() * vars.amplitude

            iterDelta = (delta % (1/times)) * times
            step = ((delta / (1/times)) | 0) % 4

            v = 0

            switch step
              when 0 then v = -iterDelta*displacement
              when 1 then v = -(1 - iterDelta)*displacement
              when 2 then v = iterDelta*displacement
              when 3 then v = (1 - iterDelta)*displacement

            state.translateX += v
