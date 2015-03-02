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

  constructor: (path, first, last) ->

    # TODO This has to be done in both ways to be usefull
    # For now, this cannot be used on objects inside transformed groups

    # Transforms the path using the matrix,
    #transformedPath = Snap.path.map(path, matrix).toString()

    # Transform all segments to cubic
    cubicPath = Snap.path.toCubic(path).toString()

    # Transform into relative to simplify
    pathComponents = Snap.path.toRelative(cubicPath)
    pathComponents.shift() # Remove the relative initial move

    N = 16 # Number of points to take in each curve to make the animation uniform
    current = (x: 0, y: 0)
    prev = (x: 0, y: 0)

    @totalLength = 0
    @lengthIndex = [] # Lengths on the whole curve
    @curveIndex = [] # Double elements of lengthIndex, corresponding bezier curve and delta

    # Take only the requested components
    if first? and last?
      pathComponents = pathComponents[first...last]

    # Preprocess all the bezier curves
    for c in pathComponents
      bzr = [
        current.x, current.y
        current.x + c[1], current.y + c[2],
        current.x + c[3], current.y + c[4],
        current.x + c[5], current.y + c[6]
      ]

      # Sample the curve on N points to calculate lengths
      for i in [0...16]
        delta = i / (N-1)
        x = Bezier.cubicBezierPosition(bzr[0], bzr[2], bzr[4], bzr[6], delta)
        y = Bezier.cubicBezierPosition(bzr[1], bzr[3], bzr[5], bzr[7], delta)

        dx = x - prev.x
        dy = y - prev.y

        @totalLength += Math.sqrt(dx*dx + dy*dy)

        @lengthIndex.push(@totalLength)
        @curveIndex.push(bzr)
        @curveIndex.push(delta)

        prev.x = x
        prev.y = y

      current.x = bzr[6]
      current.y = bzr[7]

    @lengthIndex = @lengthIndex.map (e) => e / @totalLength # Normalize lengths

  getPoint: (delta) =>

    # Find entry in index
    i = 0
    lI = @lengthIndex
    i++ while lI[i] < delta

    bzr = @curveIndex[2*i]
    bzrDelta = @curveIndex[2*i + 1]

    # If it's not the exact delta, interpolate
    if lI[i] > delta
      nextDelta = @lengthIndex[i]
      prevDelta =  @lengthIndex[i-1]
      interpolateRatio = (delta - prevDelta) / (nextDelta - prevDelta)

      if @curveIndex[2*(i-1)] != bzr # If prev is a different curve
        prevBzrDelta = 0
      else
        prevBzrDelta = @curveIndex[2*(i-1) + 1]

      bzrDelta = interpolateRatio * (bzrDelta - prevBzrDelta) + prevBzrDelta

    x: Bezier.cubicBezierPosition(bzr[0], bzr[2], bzr[4], bzr[6], bzrDelta)
    y: Bezier.cubicBezierPosition(bzr[1], bzr[3], bzr[5], bzr[7], bzrDelta)
