svgNode = $("svg")[0]

svgViewBox = svgNode.getAttribute("viewBox").match(/-?[\d\.]+/g)
svgPageWidth = parseFloat(svgViewBox[2])
svgPageHeight = parseFloat(svgViewBox[3])
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

__nextClipId = 0
createClip = (path, element) ->
  clip = svgElement("clipPath")
  clip.appendChild(path)

  id = "clip#{__nextClipId}"
  __nextClipId += 1
  clip.setAttribute('id', id)

  element.appendChild(clip)
  clip

applyClip = (element, clip) ->
  element.setAttribute("clip-path", "url(##{$(clip).attr('id')})")

localMatrix = (element) ->
  m = null
  bv = element.transform.baseVal
  if bv? and bv.length > 0
    m = bv[0]?.matrix

  m ? svgNode.createSVGMatrix()


globalMatrix = (element) -> element.getScreenCTM()

actualMatrix = (element, base) -> # Actual matrix with respect to base, including x,y translate
  baseMatrix = if base? then globalMatrix(base) else globalMatrix(svgNode)
  elementMatrix = globalMatrix(element)

  x = getFloatAttr(element, "x", 0)
  y = getFloatAttr(element, "y", 0)

  baseMatrix.inverse().multiply(elementMatrix.translate(x, y))

matrixScaleX = (matrix) -> Math.sqrt(matrix.a * matrix.a + matrix.b * matrix.b)

matrixScaleY = (matrix) -> Math.sqrt(matrix.c * matrix.c + matrix.d * matrix.d)

getStringAttr = (e, name, def) -> e.getAttribute(name) ? def
getIntAttr = (e, name, def) -> parseInt(getStringAttr(e,name)) or def
getFloatAttr = (e, name, def) -> parseFloat(getStringAttr(e,name)) or def

setAttrs = (e, attrs) ->
  for k, v of attrs
    e.setAttribute(k, v)

setStyle = (e, attrs) ->
  for k, v of attrs
    e.style[k] = v

setTransform = (e, t) ->
  if t instanceof SVGMatrix
    t = "matrix(#{t.a},#{t.b},#{t.c},#{t.d},#{t.e},#{t.f})"
  e.setAttribute("transform", t)

getObjectFromReference = (namespace, reference) ->
  if typeof reference is "string"
    c = reference.charAt(0)
    if c == "#" or c == "@" or c == "$"

      path = if namespace != "" then namespace.split(".") else []

      # Remove relative parent levels
      if reference[1..2] == "*%"
        path = []
        parentLevels = 2
      else
        parentLevels = 0
        while reference.charAt(parentLevels + 1) == "%"
          path.pop()
          parentLevels += 1

      name = reference[parentLevels+1..]
      path.push(name)
      fullName = path.join(".")

      # TODO Force the use of *% and remove extra check below????

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

toRadians = (degress) -> degress * (Math.PI / 180)
