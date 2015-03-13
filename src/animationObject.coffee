class AnimationObject

  @byFullName = {}
  @objects = []

  @createFullName: (namespace, name) ->
    if namespace != ""
      namespace + "." + name
    else
      name

  constructor: (@element, meta, w, h, raw = false) ->
    @namespace = meta.namespace ? ""
    @name = meta.name

    @fullName = AnimationObject.createFullName(@namespace, @name)

    # Animations
    if (meta.animations?)
      @animations = meta.animations

    se = Snap(@element)
    box = se.getBBox()

    if not (w? and h?)
      w = parseFloat(se.attr("width"))
      h = parseFloat(se.attr("height"))
      if isNaN(w) or isNaN(h)
        w = box.w
        h = box.h

    @width = w
    @height = h

    @baseState = null
    @currentState = null
    @provisionalState = null

    if @name? # Ignore anonymous animation objects
      AnimationObject.byFullName[@fullName] = this

    if meta.raw?
      raw = meta.raw

    # Raw AnimationObjects dont compensate, cannot be used as clipping or view, ...
    if not raw

      # To be used as a view in navigations
      @viewState = State.fromMatrix(actualMatrix(@element))

      # Base state
      s = State.fromMatrix(localMatrix(@element))
      s.opacity = $(@element).css("opacity")
      s.animationObject = this
      s.changeCenter([0.5, 0.5]) # fromMatrix has de wrong default center

      # Wrap in a group
      @origElement = @element
      group = sSvg.g()
      $(@element).replaceWith(group.node)
      group.append(@element)
      se.attr(transform: "")
      @element = group.node

      # Set base state on the group
      @setBase(s)

      # To compensate offset of objects inside a group
      box = Snap(@element).getBBox()
      @compensateDelta =
        x: box.x - s.translateX
        y: box.y - s.translateY

      # Add clip
      oe = Snap(@origElement)
      oe.attr(id: oe.id)
      use = Snap(svgElement("use"))
      use.attr("xlink:href": oe.id)

      clip = createClip(use)
      group.append(clip)

  init: () =>
    # Process meta animations
    animsMeta = @animations
    @animations = {}
    for name, meta of animsMeta
      a = new Animation(meta, @fullName) # Current namespace is the object fullName
      @animations[a.name] = a # TODO put it on Animation.byFullName

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
