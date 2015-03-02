class View
  @fromElement: (element, meta) ->
    v = new View()

    se = Snap(element)

    v.index = meta.view.index
    v.name = if meta.view.name? then meta.view.name else se.attr("id")

    v.duration = if meta.view.duration? then meta.view.duration else 0
    v.easing = if meta.view.easing? then meta.view.easing else "inout"

    v.width = se.attr("width")
    v.height = se.attr("height")
    v.state = State.fromMatrix(actualMatrix(element))

    if (meta?.view?.timeline?)
      v.animation = new Animation(meta.view.timeline)

    # Style the view
    se.attr(fill: "#777", "fill-opacity": 0.4) #TODO Another rect to avoid problems with border?

    group = sSvg.g()
    $(element).replaceWith(group.node)
    group.append(element)
    group.attr
      transform: se.attr("transform")
      cursor: "pointer"
    se.attr(transform: "")

    x = parseFloat(se.attr("x")) + parseFloat(v.width) * 0.5
    y = parseFloat(se.attr("y")) + parseFloat(v.height) * 0.5
    t = group.text(x, y, v.index.toString())
    t.attr
      "text-anchor": "middle"
      dy: ".3em"
      "font-family": "Arial"
      "font-size": parseFloat(v.width) * 0.5
      fill: "#fff"
      "fill-opacity": 0.8

    v.element = group.node

    v
