class Animation

  @byFullName = {}

  constructor: (@animDesc, @namespace, @name) ->
    @fullName = if @namespace != "" then @namespace + "." + @name else @name
    if @name?
      Animation.byFullName[@fullName] = this

  init: () =>
    if not @actions?
      @actions = []
      @targets = new Set()
      @labels = []
      @labelByName = {}
      @duration = 0
      @currentTime = 0
      @currentActions = []
      @nextAction = 0

      peekNextPositional = (o) => o.__positionals?[0]
      shiftNextPositional = (o) => o.__positionals?.shift()

      processContextPositionals = (o, vars) =>
        c = shiftNextPositional(o)
        for action in ["target", "duration", "easing", "offset", "center", "namespace", "label"]
          if c?
            vars[action] = c
            c = shiftNextPositional(o)
          else
            break

      toLongContextNames = (vars) =>
        if vars.d
          vars.duration = vars.d
          delete vars.d

        if vars.e
          vars.easing = vars.e
          delete vars.e

        if vars.o
          vars.offset = vars.o
          delete vars.o

        if vars.c
          vars.center = vars.c
          delete vars.c

        if vars.n
          vars.namespace = vars.n
          delete vars.n

        if vars.l
          vars.label = vars.l
          delete vars.l

      setContextDefaults = (vars) =>
        vars.duration ?= 1
        vars.easing ?= "linear"
        vars.center ?= [0.5, 0.5]
        vars.namespace ?= ""

      getReferences = (vars) =>
        namespace = vars.namespace
        for name, value of vars

            # Deref using context vars
            if typeof value is "string" and value.charAt(0) == "$" and vars[value[1..]]?
               value = vars[value[1..]]

            # Deref as much as it can, to allow nested variables
            loop
              dref = getObjectFromReference(namespace, value)
              break if not dref?
              value = dref

            if value?
              vars[name] = value

              if name == "target"
                @targets.add(value)

      process = (l, r, vars) =>
        parallel = true

        c = peekNextPositional(l)

        # Process step type
        if c == "-"
          parallel = false
          shiftNextPositional(l)
        else if c == "/" or c.charAt(0) == "@"
          shiftNextPositional(l)

        # Include raw animation
        c = peekNextPositional(l)
        if c == "includeRawAnim"
          anim = getObjectFromReference(vars.namespace, r.__positionals[0])
          # Replace current left and right with the desc of the reference
          [l, r] = anim.animDesc
          shiftNextPositional(l)
        else if c == "includeAnim"
          anim = getObjectFromReference(vars.namespace, r.__positionals[0])
          anim.init()

          # Add all the actions, but transform time
          currentEnd = vars.time
          for a in anim.actions
            newVars = $.extend({}, a.vars)
            newVars.time += vars.time # Apply current offset to the action
            @actions.push new Action(a.name, newVars)
            currentEnd = Math.max(currentEnd, newVars.time + newVars.duration)
          return [currentEnd, parallel]

        # Process action
        c = peekNextPositional(l)
        if Action.actionNames.has(c)
          action = c
          shiftNextPositional(l)

        # Process left context positionals
        processContextPositionals(l, vars)

        # Add right named to vars
        delete l.__positionals
        $.extend(vars, l)

        originalTime = vars.time
        currentEnd = vars.time

        if action?
          actionDesc = Action.descs[action]

          # Process right action positionals
          actionDesc.processPositionals(r, vars)

          # Process right context positionals
          processContextPositionals(r, vars)

          # Add right named to vars
          delete r.__positionals
          $.extend(vars, r)

          # Transform to long names
          actionDesc.toLongNames(vars)
          toLongContextNames(vars)

          # Add defaults on missing
          actionDesc.setDefaults(vars)
          setContextDefaults(vars)

          # Process offset
          vars.time += vars.offset or 0

          # Get references to AO, Animations and Variables
          getReferences(vars)

          # Create action on @actions
          @actions.push new Action(action, vars)

          # Update currentEnd
          currentEnd = vars.time + vars.duration
        else
          # Process offset
          currentEnd += vars.offset or vars.o or 0
          delete vars.offset
          delete vars.o

          # Get references to AO, Animations and Variables
          getReferences(vars)

          # Process children
          if r instanceof Array
            childrenEnd = currentEnd
            for c in r
              newVars = $.extend({}, vars)
              newVars.time = currentEnd
              [end, para] = process(c[0], c[1], newVars)

              if para
                childrenEnd = Math.max(childrenEnd, end)
              else
                currentEnd = end
                childrenEnd = end

            currentEnd = childrenEnd

        # Label
        if vars.label?
          l =
            name: vars.label
            time: vars.time
          @labels.push l
          @labelByName[vars.label] = l


        [currentEnd, parallel]

      [@duration, parallel] = process(@animDesc[0], @animDesc[1], (time: 0, namespace: @namespace), null)

      # Sort actions and labels
      @actions.sort((a, b) => a.time - b.time)

      @labels.sort((a, b) => a.time - b.time)
      @labels.unshift(name: "start", time: 0) # Add start label
      @labels.push(name: "end", time: @duration) # Add end label

      @goStart()

  _play: (length, onEnd) =>
    aT = (delta) => @advanceTime(delta, true)
    @currentBaseAnimation = new BaseAnimation length, aT, () =>
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
    @targets.forEach (ao) -> ao.resetState()

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

  advanceTime: (delta, execSingle = false) =>
    @currentTime += delta

    while @currentLabel < @labels.length - 1 and @labels[@currentLabel + 1].time <= @currentTime
      @_changeCurrentLabel(@currentLabel + 1)

    # Add new actions
    while @nextAction < @actions.length and @actions[@nextAction].time <= @currentTime
      a = @actions[@nextAction]
      if execSingle
        a.singleStart()
      @currentActions.push(a)
      @nextAction += 1

    # Close current actions if needed
    changed = new Set()
    @currentActions = @currentActions.filter (a) =>

      ao = a.exec(@currentTime)

      if ao?
        changed.add(ao)

      if @currentTime >= (a.time + a.duration)
        if execSingle
          a.singleEnd()
        false
      else
        true

    # Apply the provisional state to the element
    changed.forEach (ao) -> ao.applyProvisional()
