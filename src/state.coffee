class State

  # Represents the state of an AnimationObject

  constructor: () ->
    @translateX = 0
    @translateY = 0
    @scaleX = 1
    @scaleY = 1
    @rotation = 0
    @opacity = 1
    @center = [0.5, 0.5] # By default, center on the object
    @animationObject = null

  @fromMatrix: (matrix) ->
    # From http://svg.dabbles.info/snaptut-matrix-play

    deltaTransformPoint = (matrix, point) ->
      x: point.x * matrix.a + point.y * matrix.c + 0
      y: point.x * matrix.b + point.y * matrix.d + 0

    # Calculate delta transform point
    px = deltaTransformPoint(matrix, (x: 0, y: 1))
    py = deltaTransformPoint(matrix, (x: 1, y: 0))

    # Calculate skew
    skewX = ((180 / Math.PI) * Math.atan2(px.y, px.x) - 90)
    skewY = ((180 / Math.PI) * Math.atan2(py.y, py.x))

    s = new State()
    s.translateX = matrix.e
    s.translateY = matrix.f
    s.scaleX = matrixScaleX(matrix)
    s.scaleY = matrixScaleY(matrix)
    s.rotation = skewX #rotation is the same as skew x
    s.center = [0,0] # Math is based on [0,0]
    s

  width: () => @animationObject.width
  height: () => @animationObject.height

  clone: () =>
    s = new State()
    s.translateX = @translateX
    s.translateY = @translateY
    s.scaleX = @scaleX
    s.scaleY = @scaleY
    s.rotation = @rotation
    s.center = @center
    s.animationObject = @animationObject

    # TODO Clone any extra property
    s.opacity = @opacity
    s

  @_rotatePoint: (p, degress) ->
    radians = degress * (Math.PI / 180)
    sin = Math.sin(radians)
    cos = Math.cos(radians)

    x: p.x*cos - p.y*sin
    y: p.x*sin + p.y*cos

  _calcCenterChange: (c) =>
    vec =
      x: (c[0] - @center[0]) * @animationObject.width
      y: (c[1] - @center[1]) * @animationObject.height

    trans = @scaleRotatePoint(vec)

    x: trans.x - vec.x
    y: trans.y - vec.y

  changeCenter: (c) =>
    if @center[0] != c[0] or @center[1] != c[1]
      cp = @_calcCenterChange(c)

      @translateX += cp.x
      @translateY += cp.y

      @center = c

  apply: () =>
    ao = @animationObject
    setTransform(ao.element, @getMatrix())

    $(ao.origElement).css
      opacity: @opacity

  getMatrix: () =>
    # Calculate position on current center
    cp = @_calcCenterChange([0,0])

    # Apply center
    tx = @translateX + cp.x
    ty = @translateY + cp.y

    # Compensate groups
    # This is needed if group children doesn't start at group origin
    # In this case, ao.delta from origin to real children origin is scaled/rotated
    # We need to compensate this effect
    ao = @animationObject
    if ao.compensateDelta?
      delta = ao.compensateDelta
      s = ao.baseState.diff(this) # State wrt base
      p = s.scaleRotatePoint(delta)

      tx -= p.x - delta.x
      ty -= p.y - delta.y

    svgNode.createSVGMatrix().translate(tx, ty).scale(@scaleX, @scaleY).rotate(@rotation)

  transformPoint: (p) =>
    srp = @scaleRotatePoint(p)

    px = srp.x + @translateX
    py = srp.y + @translateY

    if @center[0] != 0 or @center[1] != 0
      cp = @_calcCenterChange([0,0])
      px += cp.x
      py += cp.y

    x:  px
    y:  py

  transformPointInverse: (p) =>
    px = p.x - @translateX
    py = p.y - @translateY

    if @center[0] != 0 or @center[1] != 0
      cp = @_calcCenterChange([0,0])
      px -= cp.x
      py -= cp.y

    @scaleRotatePointInverse(x: px, y: py)

  scaleRotatePoint: (p) =>
    rP = State._rotatePoint(p, @rotation)

    x: rP.x * @scaleX
    y: rP.y * @scaleY

  scaleRotatePointInverse: (p) =>
    sX = p.x / @scaleX
    sY = p.y / @scaleY

    State._rotatePoint((x: sX, y: sY), -@rotation)

  diff: (dest) =>
    # If dest center is not the right one, change it before diffing
    if dest.center[0] != @center[0] or dest.center[1] != @center[1]
      dest = dest.clone()
      dest.changeCenter(@center)

    s = new State()

    s.translateX = dest.translateX - @translateX
    s.translateY = dest.translateY - @translateY
    s.scaleX = dest.scaleX/@scaleX
    s.scaleY = dest.scaleY/@scaleY
    s.rotation = dest.rotation - @rotation

    s.opacity = @opacity
    s.center = @center
    s.animationObject = dest.animationObject

    s
