init = () ->
  # Full screen
  setAttrs(svgNode, (width: "100%", height: "100%"))

  updateWindowDimensions()
  initInkscape()

  $(svgNode).keydown (e) ->
    #if e.keyCode == 48
    #  TextScroll.byName["someText"].goToAnchor("sec1")

    if e.keyCode == 39
      Navigation.active.goNext()

    if e.keyCode == 37
      Navigation.active.goPrev()


window.addEventListener("load",init)
