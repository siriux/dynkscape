class View
  constructor: (@element, meta) ->
    se = Snap(@element)

    @id = se.attr("id")
    @index = meta?.view?.index
    @width = se.attr("width")
    @height = se.attr("height")

    @globalMatrix = globalMatrix(@element)
    @actualMatrixInverse = actualMatrix(@element).invert()

    @scale = decomposeMatrix(@globalMatrix).scaleX
