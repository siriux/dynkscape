sSvg = Snap.select("svg")
jSvg = $("svg").first()

svgViewBox = jSvg.attr("viewBox").match(/-?[\d\.]+/g)
svgPageWidth = svgViewBox[2]
svgPageHeight = svgViewBox[3]
svgProportions = svgPageWidth/svgPageHeight

updateWindowDimensions = () =>
  @windowWidth = window.innerWidth
  @windowHeight = window.innerHeight
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

createClip = (path, element) ->
  clip = Snap(svgElement("clipPath"))
  clip.append(path)
  clip.attr(id: clip.id)
  Snap(element).append(clip)
  clip.node

applyClip = (element, clip) ->
  Snap(element).attr("clip-path": "url(##{Snap(clip).id})")

localMatrix = (element) ->
  m = null
  bv = element.transform.baseVal
  if bv? and bv.length > 0
    m = bv[0]?.matrix
  new Snap.Matrix(m)

globalMatrix = (element) -> new Snap.Matrix(element.getScreenCTM())

actualMatrix = (element, base) -> # Actual matrix with respect to base, including x,y translate
  baseMatrix = if base? then globalMatrix(base) else globalMatrix(sSvg.node)
  elementMatrix = globalMatrix(element)

  e = Snap(element)

  baseMatrix.invert().add(elementMatrix).translate(e.attr("x"), e.attr("y"))

matrixScaleX = (matrix) -> Math.sqrt(matrix.a * matrix.a + matrix.b * matrix.b)

matrixScaleY = (matrix) -> Math.sqrt(matrix.c * matrix.c + matrix.d * matrix.d)

getObjectFromReference = (namespace, reference) ->
  if typeof reference is "string"
    c = reference.charAt(0)
    if c == "#" or c == "@" or c == "$"
      # TODO Parse relative
      name = reference[1..]
      if namespace != ""
        fullName = namespace + "." + name
      else
        fulName = name

      switch c
        when "#"
          ao = AnimationObject.byFullName[fullName]
          if ao? then ao else AnimationObject.byFullName[name]
        when "@"
          anim = Animation.byFullName[fullName]
          if anim? then anim else Animation.byFullName[name]
        when "$"
          v = AnimationObject.variablesByFullName[fullName]
          if v? then v else AnimationObject.variablesByFullName[name]

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
