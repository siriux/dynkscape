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

  @_stateFromMatrix: (matrix) ->
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
    s = @_stateFromMatrix(moveCoordsToMatrix(e))
    s.animationObject = ao
    s.opacity = $(e).css("opacity")

    # _stateFromMatrix has de wrong default center
    s.changeCenter([0.5, 0.5])

    s

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
    vecX = (@center[0] - c[0]) * @animationObject.width
    vecY = (@center[1] - c[1]) * @animationObject.height

    sX = vecX * @scaleX
    sY = vecY * @scaleY

    theta = @rotation * (Math.PI / 180)
    sinT = Math.sin(theta)
    cosT = Math.cos(theta)

    rX = sX*cosT - sY*sinT
    rY = sX*sinT + sY*cosT

    @translateX += vecX - rX
    @translateY += vecY - rY

    @center = c

  _toMatrix: () =>
    cx = @animationObject.width*@center[0]
    cy = @animationObject.height*@center[1]

    new Snap.Matrix()
      .translate(@translateX, @translateY)
      .scale(@scaleX, @scaleY, cx, cy)
      .rotate(@rotation, cx, cy)

  apply: () =>
    e = @animationObject.element
    Snap(e).transform(@_toMatrix())
    $(e).css("opacity", @opacity)
