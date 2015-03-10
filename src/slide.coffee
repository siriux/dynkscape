class Slide extends AnimationObject
  constructor: (element, meta) ->
    super(element)

    se = Snap(@element)
    soe = Snap(@origElement)

    @index = meta.view.index
    @name = if meta.view.name? then meta.view.name else se.attr("id")

    @duration = if meta.view.duration? then meta.view.duration else 0
    @easing = if meta.view.easing? then meta.view.easing else "inout"

    if (meta?.view?.timeline?)
      @animation = new Animation(meta.view.timeline)

    # Style
    soe.attr(fill: "#777", "fill-opacity": 0.4) #TODO Another rect to avoid problems with border?

    se.attr(cursor: "pointer")

    t = se.text(@width*0.5, @height*0.5, @index.toString())
    t.attr
      "text-anchor": "middle"
      dy: ".3em"
      "font-family": "Arial"
      "font-size": @width * 0.5
      fill: "#fff"
      "fill-opacity": 0.8
