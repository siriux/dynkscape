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

    v
