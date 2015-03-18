class Path extends AnimationObject

  constructor: (element, meta) ->
    super(element, meta, 0, 0, true) # Raw Animation object

    p =
      if "translatePath" in @element.classList
        @element
      else
        @element.querySelector(".translatePath")

    @path = svgElement("path")

    # Get segments info
    origSegments = (p.pathSegList.getItem(i) for i in [1...p.pathSegList.length])
    destSegments = @path.pathSegList

    destSegments.appendItem(p.createSVGPathSegMovetoRel(0,0))
    @segmentsInfo = for s in origSegments
      info = {}

      info.offset = @path.getTotalLength()
      info.base = @path.getPointAtLength(info.offset)
      destSegments.appendItem(s)
      info.length = @path.getTotalLength() - info.offset

      info

    @totalLength = @path.getTotalLength()

  getRangeInfo: (range) =>
    startInfo = @segmentsInfo[range[0]]
    l = 0
    for si in @segmentsInfo[range[0]...range[1]]
      l += si.length

    offset: startInfo.offset
    length: l
    base: startInfo.base

  wholeRangeInfo: () => getRangeInfo([0, @segmentsInfo.length])

  getTransform: (delta, rangeInfo) =>
    pos = rangeInfo.offset + rangeInfo.length * delta
    p = @path.getPointAtLength(pos)

    # TODO rotate and scale

    x: p.x - rangeInfo.base.x
    y: p.y - rangeInfo.base.y

### Old Bezier class, it might be of use in the future

class Bezier

  @cubicBezierPosition: (a,b,c,d,t) ->
    t2 = t*t
    t3 = t2*t

    tm = 1-t
    tm2 = tm*tm
    tm3 = tm2*tm

    # Bezier coeficients
    bc0 = tm3
    bc1 = 3 * t * tm2
    bc2 = 3 * t2 * tm
    bc3 = t3

    bc0*a + bc1*b + bc2*c + bc3*d

  constructor: (path, @N = 16) -> # N is the number of points to take in each curve to make the animation uniform

    # TODO This has to be done in both ways to be usefull
    # For now, this cannot be used on objects inside transformed groups
    # Transforms the path using the matrix,
    #transformedPath = Snap.path.map(path, matrix).toString()

    # Transform all segments to cubic
    cubicPath = Snap.path.toCubic(path).toString()

    # Transform into relative to simplify
    pathComponents = Snap.path.toRelative(cubicPath)
    pathComponents.shift() # Remove the relative initial move

    current = (x: 0, y: 0)
    prev = (x: 0, y: 0)

    @totalLength = 0
    @lengthIndex = [] # Lengths on the whole curve
    @curveIndex = [] # Double elements of lengthIndex, corresponding bezier curve and pos

    # Preprocess all the bezier curves
    for c in pathComponents
      bzr = [
        current.x, current.y
        current.x + c[1], current.y + c[2],
        current.x + c[3], current.y + c[4],
        current.x + c[5], current.y + c[6]
      ]

      # Sample the curve on N points to calculate lengths
      for i in [0...@N]
        pos = i / (@N-1)
        x = Bezier.cubicBezierPosition(bzr[0], bzr[2], bzr[4], bzr[6], pos)
        y = Bezier.cubicBezierPosition(bzr[1], bzr[3], bzr[5], bzr[7], pos)

        dx = x - prev.x
        dy = y - prev.y

        @totalLength += Math.sqrt(dx*dx + dy*dy)

        @lengthIndex.push(@totalLength)
        @curveIndex.push(bzr)
        @curveIndex.push(pos)

        prev.x = x
        prev.y = y

      current.x = bzr[6]
      current.y = bzr[7]

  getRangeInfo: (range) =>
    start = @lengthIndex[@N * range[0]]
    end = @lengthIndex[@N * range[1]] ? @totalLength

    offset: start
    length: end - start
    base: @getPoint(start)

  getPoint: (pos) =>

    # Find entry in index
    i = 0
    lI = @lengthIndex
    i++ while lI[i] < pos

    bzr = @curveIndex[2*i]
    bzrPos = @curveIndex[2*i + 1]

    # If it's not the exact pos, interpolate
    if lI[i] > pos
      nextPos = @lengthIndex[i]
      prevPos =  @lengthIndex[i-1]
      interpolateRatio = (pos - prevPos) / (nextPos - prevPos)

      if @curveIndex[2*(i-1)] != bzr # If prev is a different curve
        prevBzrPos = 0
      else
        prevBzrPos = @curveIndex[2*(i-1) + 1]

      bzrPos = interpolateRatio * (bzrPos - prevBzrPos) + prevBzrPos

    x: Bezier.cubicBezierPosition(bzr[0], bzr[2], bzr[4], bzr[6], bzrPos)
    y: Bezier.cubicBezierPosition(bzr[1], bzr[3], bzr[5], bzr[7], bzrPos)

###
