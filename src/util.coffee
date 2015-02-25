sSvg = Snap.select("svg")
jSvg = $("svg").first()

svgViewBox = jSvg.attr("viewBox").match(/-?[\d\.]+/g)
svgProportions = svgViewBox[2]/svgViewBox[3]

htmlElement = (name) -> document.createElementNS("http://www.w3.org/1999/xhtml", name)
svgElement = (name) -> document.createElementNS("http://www.w3.org/2000/svg", name)

transformPointWithMatrix = (m, x, y) -> (x: m.x(x, y), y: m.y(x, y))

localMatrix = (element) -> Snap(element).transform().localMatrix
globalMatrix = (element) -> new Snap.Matrix(Snap(element).node.getScreenCTM())
actualMatrix = (element, base) -> # Actual matrix with respect to base, including x,y translate
  baseMatrix = if base? then globalMatrix(base) else globalMatrix(sSvg)
  elementMatrix = globalMatrix(element)

  e = Snap(element)

  baseMatrix.invert().add(elementMatrix).translate(e.attr("x"), e.attr("y"))

matrixScaleX = (matrix) -> Math.sqrt(matrix.a * matrix.a + matrix.b * matrix.b)
matrixScaleY = (matrix) -> Math.sqrt(matrix.c * matrix.c + matrix.d * matrix.d)

moveCoordsToMatrix = (element) ->
  e = Snap(element)
  local = e.transform().localMatrix
  newLocal = local.translate(e.attr("x"), e.attr("y"))
  e.transform(newLocal)

  e.attr("x", 0)
  e.attr("y", 0)

  newLocal

isID = (s) ->
  if typeof s is 'string' and (s.charAt(0) is '#')
    $(s).length == 1
  else
    false

stringCmp = (a, b) ->
  if a < b
    -1
  else if a > b
    1
  else
    0

isEasing = (name) -> name in ["linear", "in", "out", "inout"]

getEasing = (name) ->
  switch name
    when "linear" then mina.linear
    when "in" then mina.easein
    when "out" then mina.easeout
    when "inout" then mina.easeinout
