class Animation

  constructor: (timeline) ->

    @actions = []
    @objects = {}
    @labels = []
    @labelByName = {}
    @duration = 0
    @currentTime = 0
    @currentActions = []
    @nextAction = 0

    process = (o, ctx) =>
      if o instanceof Array
        processSequential(o, ctx)
      else if o instanceof Object
        processParallel(o, ctx)

    processSequential = (a, ctx) =>
      c = ctx.clone()
      for l in a
        end = process(l, c)
        c = ctx.clone()
        c.time = end
      c.time

    processParallel = (o, ctx) =>
      if o.start?
        ctx.time = o.start

      if o.target?
        ctx.target = o.target

      if o.offset?
        ctx.time += o.offset

      if o.duration != undefined # Use undefined to allow null reset
        ctx.duration = o.duration
        totalDuration = o.duration

      if o.easing != undefined # Use undefined to allow null reset
        ctx.easing = o.easing

      if o.center != undefined # Use undefined to allow null reset
        ctx.center = o.center

      endTime = ctx.time

      for key, value of o
        offset = parseFloat(key)
        c = ctx.clone()
        if !isNaN(offset) # Is a number?
          c.time += offset
          end = process(value, c)
        else if isID(key)
          c.target = key
          end = process(value, c)
        else
          if key in ["start", "target", "offset", "duration", "easing", "center"]
            continue
          end = processAction(key, value, c)

        endTime = Math.max(endTime, end)

      endTime

    processAction = (key, value, ctx) =>

      value = [null] if value is null

      value = [].concat(value) # Convert to array if needed

      processTarget = () ->
        if isID(value[0])
          ctx.target = value.shift()

      processDuration = () ->
        duration = value[0]
        if !isNaN(duration)
          ctx.duration = duration
          value.shift()

      processEasing = () ->
        easing = value[0]
        if isEasing(easing)
          ctx.easing = easing
          value.shift()

      processCenter = () ->
        center = value[0]
        if center instanceof Array and center.length == 2
          ctx.center = center
          value.shift()

      switch key

        # Label

        when "label"
          l =
            name: value[0]
            time: ctx.time
          @labels.push l
          @labelByName[value[0]] = l

        # Properties

        when "translate"
          a = new Action(ctx)
          @actions.push(a)

          processTarget()

          a.translateX = value.shift()
          a.translateY = value.shift()

          processDuration()
          processEasing()

        when "scale"
          processTarget()

          sx = sy = value.shift()

          if sx instanceof Array
            sy = sx[1]
            sx = sx[0]

          processDuration()
          processEasing()
          processCenter()

          a = new Action(ctx)
          @actions.push(a)

          a.scaleX = sx
          a.scaleY = sy

        when "rotate"
          a = new Action(ctx)
          @actions.push(a)

          processTarget()

          a.rotation = value.shift()

          processDuration()
          processEasing()
          processCenter()

        when "opacity"
          a = new Action(ctx)
          @actions.push(a)

          processTarget()

          a.opacity = value.shift()

          processDuration()
          processEasing()

        # Effects

        when "attention", "hide", "show", "translateOnId"
          a = new Action(ctx)
          @actions.push(a)

          a.effect = key

          if key in ["attention", "hide", "show"]
            processTarget()
            a.type = value.shift()

          else if key is "translateOnId"
            # Target cannot be provided explicitly, otherwise, it's ambiguous
            a.pathId = value.shift()
          else
            null # scaleOnId, rotateOnId

          processDuration()
          processEasing()

          initEffect(key, a)

        else
          return ctx.time # Avoid adding extra duration

      ctx.fillDefaults()

      ctx.time + ctx.duration

    @duration = process(timeline, new ActionContext(), null)

    # Sort actions and labels
    compareActions = (a, b) => ActionContext.compare(a.context, b.context)
    @actions.sort(compareActions)

    @labels.sort((a, b) => a.time - b.time)
    @labels.unshift(name: "start", time: 0) # Add start label
    @labels.push(name: "end", time: @duration) # Add end label

    # De-duplicate
    l = @actions.length
    for i in [0..l-1] # Avoid last
      if @actions[i]?
        j = 1
        while i+j < l and compareActions(@actions[i], @actions[i+j]) == 0
          e = @actions[i+j]
          @actions[i].merge(e) # Merge action e into the current action
          @actions[i+j] = null # Set to null for later removal
          j += 1
    @actions = (e for e in @actions when e?) # Remove null elements

    # Init animation objects
    for e in @actions
      @objects[e.context.target] = true

    for k, v of @objects
      o = $(k)
      if o.length == 1
        ao = new AnimationObject(o[0])
        ao.setBase(State.fromAnimationObject(ao))

        @objects[k] = ao
      else
        delete @objects[k]

    @goStart()

  _play: (length, onEnd) =>
    @currentBaseAnimation = new BaseAnimation length, @advanceTime, () =>
      @currentBaseAnimation = null
      onEnd?()
    @currentBaseAnimation.play()

  _changeCurrentLabel: (newLabel) =>
    @currentLabel = newLabel
    if @labelChangedCallback?
      @labelChangedCallback(@currentLabel)

  play: (onEnd) =>
    if @currentTime >= @duration
      @goStart()

    @_play(@duration - @currentTime, onEnd)

  playLabel: () =>
    end = @labels[@currentLabel + 1]?.time
    if not end?
      end = @duration

    cLabel = @currentLabel
    @goStart()
    @advanceTime(@labels[cLabel].time)

    @_play(end - @currentTime)

  pause: () =>
    @currentBaseAnimation?.pause()

  goStart: () =>
    o.resetState() for k, o of @objects

    @currentTime = 0
    @currentActions = []
    @nextAction = 0
    @_changeCurrentLabel(0)

    @currentBaseAnimation = null

    @advanceTime(0)

  goEnd: () =>
    @goStart()
    @advanceTime(@duration)

  nextLabel: () =>
    if @currentLabel < @labels.length - 1
      @advanceTime(@labels[@currentLabel + 1].time - @currentTime)

  prevLabel: () =>
    if @currentLabel > 0
      prevLabel = @currentLabel - 1
      @goStart()
      @advanceTime(@labels[prevLabel].time)

  advanceTime: (delta) =>
    @currentTime += delta

    while @currentLabel < @labels.length - 1 and @labels[@currentLabel + 1].time <= @currentTime
      @_changeCurrentLabel(@currentLabel + 1)

    changed = new Set()

    # Add new actions
    while @nextAction < @actions.length and @actions[@nextAction].context.time <= @currentTime
      @currentActions.push(@actions[@nextAction])
      @nextAction += 1

    # Close current actions if needed
    @currentActions = @currentActions.filter (a) =>
      ctx = a.context
      target = ctx.target
      ao = @objects[target]

      changed.add(ao)
      ao.addProvisionalAction(a, @currentTime)

      if @currentTime >= ctx.time + ctx.duration
        # If closing, apply the action to the current state too
        # so that in next iteration, it's taken into account
        ao.addAction(a, @currentTime)
        false
      else
        true

    # Apply the provisional state to the element
    changed.forEach (ao) -> ao.applyProvisional()
