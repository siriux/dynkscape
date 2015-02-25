_effectDescs = {}

registerEffect = (effect) ->
  _effectDescs[effect.name] = effect

applyEffectDefaults = (context, effect, action) ->
  d = _effectDescs[effect]?.defaults
  if typeof d is "function"
    d(context, action)
  else
    context.fillDefaults(d)

applyEffect = (effect, action, state, delta, rawDelta) ->
  _effectDescs[effect]?.f(action, state, delta, rawDelta)

registerEffect
  name: "attention"
  defaults:
    easing: "inout"
    duration: 500
  f: (action, state, delta, rawDelta) ->
    switch action.type
      when "shake"
        if 0 < delta < 1 # Avoid affecting it outside of the effect
          times = 4 * 4 # each shake it's divided in 4 steps
          displacement = state.width() / 20

          iterDelta = (delta % (1/times)) * times
          step = ((delta / (1/times)) | 0) % 4

          v = 0

          switch step
            when 0 then v = -iterDelta*displacement
            when 1 then v = -(1 - iterDelta)*displacement
            when 2 then v = iterDelta*displacement
            when 3 then v = (1 - iterDelta)*displacement

          state.translateX += v

registerEffect
  name: "hide"
  defaults:
    easing: "in"
    duration: 500
  f: (action, state, delta, rawDelta) ->
    switch action.type
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
