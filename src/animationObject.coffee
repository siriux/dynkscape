class AnimationObject

  @byFullName = {}
  @variablesByFullName = {}
  @objects = []

  @createFullName: (namespace, name) ->
    if namespace? and namespace != ""
      namespace + "." + name
    else
      name

  constructor: (@element, @meta, @width, @height, raw = false) ->
    @namespace = @meta.namespace

    if typeof @namespace != "string"
      @namespace = ""

    @name = @meta.name

    @fullName = AnimationObject.createFullName(@namespace, @name)

    if @meta.type?
      @element.setAttribute("class", "#{@meta.type} #{@element.getAttribute("class")}")

    $(@element).data("fullName", @fullName)

    @reference = "##{@fullName}"

    if @name? # Ignore anonymous animation objects
      AnimationObject.byFullName[@fullName] = this

    if @meta.raw?
      raw = @meta.raw

    @index = @meta.index

    @origOffset =
      x: getFloatAttr(@element, "x", getFloatAttr(@element, "cx", 0))
      y: getFloatAttr(@element, "y", getFloatAttr(@element, "cy", 0))

    @globalOrigMatrix = globalMatrix(@element)
    @localOrigMatrix = localMatrix(@element)
    @actualOrigMatrix = actualMatrix(@element)
    @externalOrigMatrix = globalMatrix(svgNode).inverse().multiply(@globalOrigMatrix).multiply(@localOrigMatrix.inverse())

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

      # Base state
      s = State.fromMatrix(@localOrigMatrix)
      s.opacity = $(@element).css("opacity")
      s.animationObject = this

      box = @element.getBBox()
      if not (@width? and @height?)
        @width = box.width
        @height = box.height

      # Wrap in a group
      @origElement = @element
      group = svgElement("g")
      $(@element).replaceWith(group)
      group.appendChild(@element)
      setTransform(@element, "")
      @element = group

      # Set base state on the group
      @setBase(s)

      # To compensate offset of objects inside the group
      box = @element.getBBox() # New box, because @element changed
      @compensateDelta =
        x: box.x
        y: box.y

  init: () =>
    # Set as view on navigation, if an index is provided
    if @index?
      @navigation = AnimationObject.byFullName[@namespace]
      @navigation.viewList[@index] = this

      $(@element).click () =>
        @navigation.goTo(@index)
        @navigation._setShowSlides(false) # Even if it's not a slide itself
      @element.setAttribute("cursor", "pointer")

    # Init animations
    if @animations?
      for anim in @animations
        anim.init() # FIXME We cannot init this here, we have to wait until every object has been initialized

    @mainAnimation = Animation.byFullName[@fullName + ".main"]

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

  currentDimensions: () =>
    if @currentState?
      p = @currentState.scalePoint((x: @width, y: @height))

      width: p.x
      height: p.y
    else
      width: @width
      height: @height
