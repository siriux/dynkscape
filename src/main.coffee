init = () ->
  # Full screen
  $("svg")
    .attr("width", "100%")
    .attr("height", "100%")

  initInkscape()

  $("flowRoot").each (idx, root) -> flowToScroll(root)

  mainParent = $("svg")[0]
  layerElements = (l.element for l in inkscapeLayers)
  mainNavigation = new Navigation(mainParent, layerElements)

  layerNavigation =
    createNavigationForLayer("zoomPanTest", mainNavigation.container, "zoomPanTestViewport", false)

  $("svg").keypress () ->
    mainNavigation.navigateToElement($("#view1")[0], (duration: 1000, easing: mina.easeout))

window.addEventListener("load",init)
