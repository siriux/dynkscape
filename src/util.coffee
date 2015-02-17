# Globals
sSvg = Snap.select("svg")

# Helper functions

htmlElement = (name) -> document.createElementNS("http://www.w3.org/1999/xhtml", name)
svgElement = (name) -> document.createElementNS("http://www.w3.org/2000/svg", name)

localMatrix = (element) -> element.transform().localMatrix
globalMatrix = (element) -> element.transform().globalMatrix

# From http://svg.dabbles.info/snaptut-matrix-play
decomposeMatrix = (matrix) ->

  deltaTransformPoint = (matrix, point) ->
    x: point.x * matrix.a + point.y * matrix.c + 0
    y: point.x * matrix.b + point.y * matrix.d + 0

  # Calculate delta transform point
  px = deltaTransformPoint(matrix, (x: 0, y: 1))
  py = deltaTransformPoint(matrix, (x: 1, y: 0))

  # Calculate skew
  skewX = ((180 / Math.PI) * Math.atan2(px.y, px.x) - 90)
  skewY = ((180 / Math.PI) * Math.atan2(py.y, py.x))

  translateX: matrix.e
  translateY: matrix.f
  scaleX: Math.sqrt(matrix.a * matrix.a + matrix.b * matrix.b)
  scaleY: Math.sqrt(matrix.c * matrix.c + matrix.d * matrix.d)
  skewX: skewX
  skewY: skewY
  rotation: skewX #rotation is the same as skew x
