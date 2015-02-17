init = () ->
  # Full screen
  $("svg")
    .attr("width", "100%")
    .attr("height", "100%")

  initInkscape()

  $("flowRoot").each (idx, root) -> flowToScroll(root)

  initZoomPan()



window.addEventListener("load",init)
