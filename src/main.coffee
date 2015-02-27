init = () ->
  # Full screen
  jSvg
    .attr("width", "100%")
    .attr("height", "100%")

  updateWindowDimensions()
  initInkscape()

  $("flowRoot").each (idx, root) -> flowToScroll(root)

  # Init main navigation !
  new Navigation(jSvg[0])

  setTimeout run, 0


run = () ->
  #v = Navigation.main.viewsByName["MainSlide0"]
  #v?.play()

  jSvg.keydown (e) ->
    if e.keyCode == 48
      Navigation.active.goTo(0)

    if e.keyCode == 39
      Navigation.active.goNext()

    if e.keyCode == 37
      Navigation.active.goPrev()


window.addEventListener("load",init)
