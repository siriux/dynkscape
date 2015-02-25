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

        when "attention", "hide", "show"
          a = new Action(ctx)
          @actions.push(a)

          a.effect = key

          processTarget()

          a.type = value.shift()

          processDuration()
          processEasing()

          applyEffectDefaults(ctx, key, a)

        else
          return ctx.time # Avoid adding extra duration

      ctx.fillDefaults()

      ctx.time + ctx.duration

    @duration = process(timeline, new ActionContext(), null)

    # Sort actions and labels
    compareActions = (a, b) => ActionContext.compare(a.context, b.context)
    @actions.sort(compareActions)

    @labels.sort((a, b) => a.time - b.time)

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
        e = o[0]

        # Get dimensions
        so = Snap(e)
        w = parseFloat(so.attr("width"))
        h = parseFloat(so.attr("height"))
        if isNaN(w) or isNaN(h)
          box = so.getBBox()
          w = box.w
          h = box.h

        ao = new AnimationObject(e, w, h)

        ao.setBase(State.fromAnimationObject(ao))

        @objects[k] = ao
      else
        delete @objects[k]

  resetObjects: () => o.reset() for k, o of @objects

  _play: (length) =>
    @resetObjects()

    start = null
    last = null

    step = (timestamp) =>
      if !start
        start = timestamp
        last = start
      progress = timestamp - start
      delta = timestamp - last
      last = timestamp
      @advanceTime(delta)
      if (progress < length)
        window.requestAnimationFrame(step)

    window.requestAnimationFrame(step)

  play: (dest) =>
    @currentTime = 0
    @currentActions = []
    @nextAction = 0

    if dest?
      if typeof dest is 'string'
        l = @labelByName[dest]

      if typeof dest is 'number'
        l = @labels[dest]

      if l?
        @_play(l.time)
    else
      @_play(@duration)

  advanceTime: (delta) =>
    @currentTime += delta

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
    changed.forEach (o) -> o.applyProvisional()
