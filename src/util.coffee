sSvg = Snap.select("svg")
jSvg = $("svg").first()

svgViewBox = jSvg.attr("viewBox").match(/-?[\d\.]+/g)
svgPageWidth = svgViewBox[2]
svgPageHeight = svgViewBox[3]
svgProportions = svgPageWidth/svgPageHeight

updateWindowDimensions = () =>
  @windowWidth = $(window).width()
  @windowHeight = $(window).height()
  @windowProportions = @windowWidth/@windowHeight

  @svgPageCorrectedWidth = svgPageWidth
  @svgPageCorrectedHeight = svgPageHeight

  if @windowProportions <= svgProportions
    @svgPageScale = @windowWidth / @svgPageWidth
    @svgPageCorrectedHeight = svgPageCorrectedWidth / @windowProportions
  else
    @svgPageScale = @windowHeight / @svgPageHeight
    @svgPageCorrectedWidth = svgPageCorrectedHeight * @windowProportions

  @svgPageOffsetX = (@windowWidth - (@svgPageWidth*@svgPageScale)) / 2
  @svgPageOffsetY = (@windowHeight - (@svgPageHeight*@svgPageScale)) / 2

$(window).resize(updateWindowDimensions)

htmlElement = (name) -> document.createElementNS("http://www.w3.org/1999/xhtml", name)
svgElement = (name) -> document.createElementNS("http://www.w3.org/2000/svg", name)

localMatrix = (element) -> Snap(element).transform().localMatrix
globalMatrix = (element) -> new Snap.Matrix(Snap(element).node.getScreenCTM())
actualMatrix = (element, base) -> # Actual matrix with respect to base, including x,y translate
  baseMatrix = if base? then globalMatrix(base) else globalMatrix(sSvg)
  elementMatrix = globalMatrix(element)

  e = Snap(element)

  baseMatrix.invert().add(elementMatrix).translate(e.attr("x"), e.attr("y"))

matrixScaleX = (matrix) -> Math.sqrt(matrix.a * matrix.a + matrix.b * matrix.b)
matrixScaleY = (matrix) -> Math.sqrt(matrix.c * matrix.c + matrix.d * matrix.d)

rotatePoint = (p, degress) ->
  radians = degress * (Math.PI / 180)
  sin = Math.sin(radians)
  cos = Math.cos(radians)

  x: p.x*cos - p.y*sin
  y: p.x*sin + p.y*cos

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

animate = (length, advanceTime, onEnd) ->
  start = null
  last = null

  step = (timestamp) =>
    if !start
      start = timestamp
      last = start
    progress = timestamp - start
    delta = timestamp - last
    last = timestamp
    advanceTime(delta)
    if (progress < length)
      window.requestAnimationFrame(step)
    else if onEnd?
      onEnd()

  window.requestAnimationFrame(step)

isEasing = (name) -> name in ["linear", "in", "out", "inout"]

getEasing = (name) ->
  switch name
    when "linear" then mina.linear
    when "in" then mina.easein
    when "out" then mina.easeout
    when "inout" then mina.easeinout
