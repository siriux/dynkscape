class BaseAnimation
  constructor: (@length, @_advanceTime, @_onEnd) ->
    @_last = null
    @progress = 0
    @paused = true

  step: (timestamp) =>
    if not @paused
      if !@_last
        @_last = timestamp
      delta = timestamp - @_last
      @progress += delta
      @_last = timestamp
      @_advanceTime(delta)
      if (@progress < @length)
        window.requestAnimationFrame(@step)
      else if @_onEnd?
        @_onEnd()

  play: () =>
    if @pause
      @_last = null

    @paused = false
    window.requestAnimationFrame(@step)

  pause: () =>
    @paused = true
