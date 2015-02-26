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

    # TODO origin for scale, and another one for rotation

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

  @fromAnimationObject: (ao) ->
    e = ao.element
    s = @fromMatrix(moveCoordsToMatrix(e))
    s.animationObject = ao
    s.opacity = $(e).css("opacity")

    # fromMatrix has de wrong default center
    s.changeCenter([0.5, 0.5])

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
    s.opacity = @opacity
    s.center = [@center[0], @center[1]]
    s.animationObject = @animationObject
    s

  changeCenter: (c) =>
    vec =
      x: (c[0] - @center[0]) * @animationObject.width
      y: (c[1] - @center[1]) * @animationObject.height

    trans = @transformPoint(vec)

    @translateX = trans.x - vec.x
    @translateY = trans.y - vec.y

    @center = c

  apply: () =>

    # Calculate position on current center
    vec =
      x: - @center[0] * @animationObject.width
      y: - @center[1] * @animationObject.height

    trans = @transformPoint(vec)

    tx = trans.x - vec.x
    ty = trans.y - vec.y

    # Apply transform

    e = $(@animationObject.element)
    e.attr
      transform: "translate(#{tx},#{ty}) scale(#{@scaleX},#{@scaleX}) rotate(#{@rotation})"

    e.css
      opacity: @opacity

  transformPoint: (p) => # Don't take into account center !!
    rP = rotatePoint(p, @rotation)

    sX = rP.x * @scaleX
    sY = rP.y * @scaleY

    x: sX + @translateX
    y: sY + @translateY

  transformPointInverse: (p) => # Don't take into account center !!
    tX = p.x - @translateX
    tY = p.y - @translateY

    sX = tX / @scaleX
    sY = tY / @scaleY

    rotatePoint((x: sX, y: sY), -@rotation)

  scaleRotatePointInverse: (p) => # Don't take into account center !!
    sX = p.x / @scaleX
    sY = p.y / @scaleY

    rotatePoint((x: sX, y: sY), -@rotation)

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
    s.animationObject = null

    s
