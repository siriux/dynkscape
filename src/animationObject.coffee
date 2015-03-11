class AnimationObject

  @byFullName = {}

  constructor: (@element, meta, w, h, raw = false) ->
    @namespace = meta.namespace ? ""
    @name = meta.name

    if @namespace != ""
      @fullName = @namespace + "." + @name
    else
      @fullName = @name

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

      # Add clipPath
      clip = Snap(svgElement("clipPath"))
      use = Snap(svgElement("use"))

      oe = Snap(@origElement)
      oe.attr(id: oe.id)
      use.attr("xlink:href": oe.id)

      clip.append(use)
      clip.attr(id: clip.id)
      group.append(clip)

  init: () =>
    # Process meta animations
    for name, meta of @animations
      @animations[name] = new Animation(meta, @fullName) # current namespace is the object fullName

  setBase: (state) =>
    state.animationObject = this
    @baseState = state
    @resetState()

  resetState: () =>
    @baseState.apply()
    @currentState = @baseState.clone()

  addAction: (a, time) => a.applyTo(@currentState, time)

  applyCurrent: () =>
    @currentState.apply()

  addProvisionalAction: (a, time) =>
    if not @provisionalState?
      @provisionalState = @currentState.clone()
    a.applyTo(@provisionalState, time)

  applyProvisional: () =>
    @provisionalState.apply()
    @provisionalState = null
