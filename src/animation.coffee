class ActionContext
  constructor: () ->
    @time = 0
    @target
    @duration = 1000
    @easing = "linear"

  clone: () ->
    ctx = new ActionContext()
    ctx.time = @time
    ctx.target = @target
    ctx.duration = @duration
    ctx.easing = @easing
    ctx

  @compare: (a, b) ->
    if a.time != b.time
      a.time - b.time
    else if a.target != b.target
      stringCmp(a.target, b.target)
    else if a.duration != b.duration
      a.duration - b.duration
    else
      stringCmp(a.easing, b.easing)

class Animation

  constructor: (timeline) ->

    entries = []

    process = (o, ctx) ->
      if o instanceof Array
        processSequential(o, ctx)
      else if o instanceof Object
        processParallel(o, ctx)

    processSequential = (a, ctx) ->
      c = ctx
      for l in a
        end = process(l, c)
        c = ctx.clone()
        c.time = end
      c.time

    processParallel = (o, ctx) ->
      if o.start?
        ctx.time = o.start

      if o.target?
        ctx.target = o.target

      if o.offset?
        ctx.time += o.offset

      if o.duration?
        ctx.duration = o.duration
        totalDuration = o.duration

      if o.easing?
        ctx.easing = o.easing

      endTime = ctx.time + ctx.duration

      for key, value of o
        offset = parseFloat(key)
        if !isNaN(offset) # Is a number?
          c = ctx.clone()
          c.time += offset
          end = process(value, c)
        else if isID(key)
          c = ctx.clone()
          c.target = key
          end = process(value, c)
        else
          if key in ["start", "target", "offset", "duration", "easing"]
            continue
          end = processEntry(key, value, ctx.clone())

        endTime = Math.max(endTime, end)

      endTime

    processEntry = (key, value, ctx) ->

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

      switch key

        # Properties

        when "translate"
          processTarget()

          x = value.shift()
          y = value.shift()

          processDuration()
          processEasing()

          entries.push
            context: ctx
            translateX: x
            translateY: y
        when "scale"
          processTarget()

          sx = sy = value.shift()

          if sx instanceof Array
            sy = sx[1]
            sx = sx[0]

          processDuration()
          processEasing()

          entries.push
            context: ctx
            scaleX: sx
            scaleY: sy

        when "rotate"
          processTarget()

          r = value.shift()

          processDuration()
          processEasing()

          entries.push
            context: ctx
            rotate: r

        when "opacity"
          processTarget()

          o = value.shift()

          processDuration()
          processEasing()

          entries.push
            context: ctx
            opacity: o

        # Effects

        when "attention", "hide", "show"
          processTarget()

          t = value.shift()

          processDuration()
          processEasing()

          entries.push
            context: ctx
            effect: key
            type: t

      ctx.time + ctx.duration

    process(timeline, new ActionContext(), null)

    compareActions = (a, b) -> ActionContext.compare(a.context, b.context)
    entries.sort(compareActions)

    # De-duplicate
    l = entries.length
    for i in [0..l-1] # Avoid last
      if entries[i]?
        j = 1
        while i+j < l and compareActions(entries[i], entries[i+j]) == 0
          e = entries[i+j]
          delete e.context # Remove the context before extending
          $.extend(entries[i], e) # Extend original object with e
          entries[i+j] = null # Set to null for later removal
          j += 1
    entries = (e for e in entries when e?) # Remove null elements

    console.log JSON.stringify(entries, null, 2)
