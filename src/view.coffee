class View
  constructor: (@element, meta) ->
    se = Snap(@element)

    @id = se.attr("id")
    @index = meta?.view?.index

    @width = se.attr("width")
    @height = se.attr("height")
    @state = State.fromMatrix(actualMatrix(@element))

    if (meta?.view?.timeline?)
      @animation = new Animation(meta.view.timeline)

  play: (dest) -> @animation.play(dest)
