class AnimationObject

  @byFullName = {}
  @variablesByFullName = {}
  @objects = []

  @createFullName: (namespace, name) ->
    if namespace != ""
      namespace + "." + name
    else
      name

  constructor: (@element, @meta, @width, @height, raw = false) ->
    @namespace = @meta.namespace ? ""
    @name = @meta.name

    @fullName = AnimationObject.createFullName(@namespace, @name)

    if @name? # Ignore anonymous animation objects
      AnimationObject.byFullName[@fullName] = this

    if @meta.raw?
      raw = @meta.raw

    # Process variables
    if @meta.variables?
      for varName, value of @meta.variables
        varFullName = AnimationObject.createFullName(@fullName, varName) # Current namespace is the object fullName
        AnimationObject.variablesByFullName[varFullName] = value

    # Process animations
    if @meta.animations?
      @animations =
        for name, animDesc of @meta.animations
          name = animDesc[0].__positionals[0][1..]
          new Animation(animDesc, @fullName, name) # Current namespace is the object fullName

    # Process raw animations (wont be initialized, are just a template)
    if @meta.rawAnimations?
      for name, animDesc of @meta.rawAnimations
        name = animDesc[0].__positionals[0][1..]
        new Animation(animDesc, @fullName, name) # Current namespace is the object fullName

    # Raw AnimationObjects dont compensate, cannot be used as clipping or view, ...
    if not raw

      # To be used as a view in navigations
      @viewState = State.fromMatrix(actualMatrix(@element))

      # Base state
      s = State.fromMatrix(localMatrix(@element))
      s.opacity = $(@element).css("opacity")
      s.animationObject = this

      box = @element.getBBox()

      if not (@width? and @height?)
        @width = getFloatAttr(@element, "width")
        @height = getFloatAttr(@element, "height")
        if isNaN(@width) or isNaN(@height)
          @width = box.width
          @height = box.height

      # To compensate offset of objects inside a group
      trfP = s.transformPoint(box)
      @compensateDelta =
        x: trfP.x - s.translateX
        y: trfP.y - s.translateY

      # fromMatrix has de wrong default center
      s.changeCenter([0.5, 0.5])

      # Wrap in a group
      @origElement = @element
      group = svgElement("g")
      $(@element).replaceWith(group)
      group.appendChild(@element)
      setTransform(@element, "")
      @element = group

      # Set base state on the group
      @setBase(s)

  init: () =>
    # Init animations
    if @animations?
      for anim in @animations
        anim.init()

  setBase: (state) =>
    state.animationObject = this
    @baseState = state
    @resetState()

  resetState: () =>
    @baseState.apply()
    @currentState = @baseState.clone()

  applyCurrent: () =>
    @currentState.apply()

  getProvisional: () =>
    if not @provisionalState?
      @provisionalState = @currentState.clone()
    @provisionalState

  applyProvisional: () =>
    @provisionalState.apply()
    @provisionalState = null
