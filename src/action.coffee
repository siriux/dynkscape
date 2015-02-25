class ActionContext
  constructor: () ->
    @time = 0
    @target
    @duration = 1000
    @easing = "linear"
    @center = [0.5, 0.5]

  clone: () ->
    ctx = new ActionContext()
    ctx.time = @time
    ctx.target = @target
    ctx.duration = @duration
    ctx.easing = @easing
    ctx.center = [@center[0], @center[1]]
    ctx

  @compare: (a, b) ->
    if a.time != b.time
      a.time - b.time
    else if a.target != b.target
      stringCmp(a.target, b.target)
    else if a.duration != b.duration
      a.duration - b.duration
    else if a.easing != b.easing
      stringCmp(a.easing, b.easing)
    else
      stringCmp(a.center.toString(), b.center.toString()) # Quick & Dirty, xD

class Action

  # Represents an action that can be performed agains a State

  constructor: (ctx) ->
    @context = ctx

  merge: (a) =>
    if a.translateX?
      @translateX = a.translateX

    if a.translateY?
      @translateY = a.translateY

    if a.scaleX?
      @scaleX = a.scaleX

    if a.scaleY?
      @scaleY = a.scaleY

    if a.rotation?
      @rotation = a.rotation

    if a.opacity?
      @opacity = a.opacity


  applyTo: (state, time) =>

    # If state center is not the right one, change it before applying
    if state.center[0] != @context.center[0] or state.center[1] != @context.center[1]
      state.changeCenter(@context.center)

    offset = time - @context.time
    delta = Math.min(Math.max(offset / @context.duration, 0), 1)

    if 0 < delta < 1
      delta = getEasing(@context.easing)(delta)

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
