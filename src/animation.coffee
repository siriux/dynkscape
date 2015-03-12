class Animation

  @byFullName = {}

  constructor: (animDesc, @namespace, @name) -> # @name is optional, it can be parsed from the desc

    @actions = []
    @targets = new Set()
    @labels = []
    @labelByName = {}
    @duration = 0
    @currentTime = 0
    @currentActions = []
    @nextAction = 0

    shiftNextPositional = (o) => o.__positionals?.shift()

    processContextPositionals = (o, vars) =>
      c = shiftNextPositional(o)
      if c?
        vars.target = c

      c = shiftNextPositional(o)
      if c?
        vars.duration = c

      c = shiftNextPositional(o)
      if c?
        vars.easing = c

      c = shiftNextPositional(o)
      if c?
        vars.offset = c

      c = shiftNextPositional(o)
      if c?
        vars.center = c

      c = shiftNextPositional(o)
      if c?
        vars.namespace = c

      c = shiftNextPositional(o)
      if c?
        vars.label = c

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
        if typeof value is "string"
          switch value.chatAt(0)
            when "#"
              # TODO Parse relative and try raw
              ao = AnimationObject.byFullName[namespace + "." + value[1..]]
              vars[name] = ao
              if name == "target"
                @targets.add(ao)
            # TODO Animations and variables

    process = (l, r, vars) =>
      parallel = true

      c = shiftNextPositional(l)

      # Process step type
      if c == "-"
        parallel = false
        c = shiftNextPositional(l)
      else if c == "/"
        c = shiftNextPositional(l)
      else if c.charAt(0) == "@"
        @name = c[1..]
        c = shiftNextPositional(l)

      # Process action
      if c in Action.actionNames # TODO
        action = c
        c = shiftNextPositional(l)

      # Process left context positionals
      processContextPositionals(l, vars)

      # Add right named to vars
      delete l.__positionals
      $.extend(vars, l)

      originalTime = vars.time
      currentEnd = vars.time

      if action?
        # Process right action positionals
        Action.processPositionals[action](r, vars) # TODO

        # Process right context positionals
        processContextPositionals(r, vars)

        # Add right named to vars
        delete r.__positionals
        $.extend(vars, r)

        # Transform to long names
        Action.toLongNames[action](vars) # TODO
        toLongContextNames(vars)

        # Add defaults on missing
        Action.setDefaults[action](vars) # TODO
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
          for c in r
            newVars = $.extend({}, vars)
            newVars.time = currentEnd
            currentEnd = process(c[0], c[1], newVars)

      # Label
      if vars.label?
        l =
          name: vars.label
          time: vars.time
        @labels.push l
        @labelByName[vars.label] = l

      if parallel
        originalTime
      else
        currentEnd

    @duration = process(animDesc[0], animDesc[1], (time: 0, namespace: namespace), null)

    # Sort actions and labels
    compareActions = (a, b) => ActionContext.compare(a.context, b.context)
    @actions.sort(compareActions)

    @labels.sort((a, b) => a.time - b.time)
    @labels.unshift(name: "start", time: 0) # Add start label
    @labels.push(name: "end", time: @duration) # Add end label

    @fullname = if @namespace != "" then @namespace + "." + @name else @name
    Animation.byFullName[@fullname] = this

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
      ao = ctx.target

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
