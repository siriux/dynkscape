class Path extends AnimationObject

  constructor: (element, meta) ->
    super(element, meta, 0, 0, true) # Raw Animation object

    sp = Snap(@element)
    path =
     if sp.hasClass("translatePath")
       sp
     else
       sp.select(".translatePath")

    pathString = path.attr("d")
    @bezier = new Bezier(pathString)

  getRangeInfo: (range) => @bezier.getRangeInfo(range)

  wholeRangeInfo: () =>
    offset: 0
    length: @bezier.totalLength
    base:
      x: 0
      y: 0

  getTransform: (delta, rangeInfo) =>
    pos = rangeInfo.offset + rangeInfo.length * delta
    p = @bezier.getPoint(pos)

    # TODO rotate and scale

    x: p.x - rangeInfo.base.x
    y: p.y - rangeInfo.base.y
