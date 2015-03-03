init = () ->
  # Full screen
  jSvg
    .attr("width", "100%")
    .attr("height", "100%")

  updateWindowDimensions()
  initInkscape()

  # Init main navigation !
  new Navigation(jSvg[0])

  setTimeout run, 0


run = () ->

  jSvg.keydown (e) ->
    if e.keyCode == 48
      TextScroll.byName["someText"].goToAnchor("sec1")

    if e.keyCode == 39
      Navigation.active.goNext()

    if e.keyCode == 37
      Navigation.active.goPrev()


window.addEventListener("load",init)
