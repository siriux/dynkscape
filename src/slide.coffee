class Slide extends AnimationObject
  constructor: (element, meta) ->
    super(element, meta)

    @index = meta.slide.index

    @duration = if meta.slide.duration? then meta.slide.duration else 0
    @easing = if meta.slide.easing? then meta.slide.easing else "inout"

    # Style
    Snap(@origElement).attr(fill: "#777", "fill-opacity": 0.4) #TODO Another rect to avoid problems with border?

    se = Snap(@element)
    se.attr(cursor: "pointer")

    x = getFloatAttr(@origElement, "x", 0)
    y = getFloatAttr(@origElement, "y", 0)

    t = se.text(x + @width*0.5, y + @height*0.5, @index.toString())
    t.attr
      "text-anchor": "middle"
      dy: ".3em"
      "font-family": "Arial"
      "font-size": @width * 0.5
      fill: "#fff"
      "fill-opacity": 0.8

  init: () =>
    super()
    @slideAnimation = Animation.byFullName[@fullName + ".slide"]
    @navigation = AnimationObject.byFullName[@namespace]

    @navigation.slideList[@index] = this

    $(@element).click () =>
      @navigation.goTo(@index)
      @navigation._setShowViews(false)
