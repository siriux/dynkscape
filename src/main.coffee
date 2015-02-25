init = () ->
  # Full screen
  $("svg")
    .attr("width", "100%")
    .attr("height", "100%")

  initInkscape()

  $("flowRoot").each (idx, root) -> flowToScroll(root)

  mainNavigation = new Navigation()

  $("svg").keydown (e) ->
    if e.keyCode == 48
      mainNavigation.goHome((duration: 1000, easing: mina.easeout))

    if e.keyCode == 39
      mainNavigation.goNext((duration: 1000, easing: mina.easeout))

    if e.keyCode == 37
      mainNavigation.goPrev((duration: 1000, easing: mina.easeout))

  setTimeout run, 0

run = () ->
  n = Navigation.byName[""]
  n.goTo(0)
  n.playCurrentView()

window.addEventListener("load",init)
