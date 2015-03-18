init = () ->
  # Full screen
  setAttrs(svgNode, (width: "100%", height: "100%"))

  updateWindowDimensions()
  initInkscape()

  switch window.location.hash
    when "#restore"
      loadDocumentState()
    when "#reset"
      saveEmptyDocumentState()
      window.history.pushState("", document.title, window.location.pathname)
      window.location.reload()

  $(window).on 'hashchange', () -> window.location.reload()

  $(window).unload () -> saveDocumentState()

  $(svgNode).keydown (e) ->
    #if e.keyCode == 48
    #  TextScroll.byName["someText"].goToAnchor("sec1")

    if e.keyCode == 39
      Navigation.active.goNext()

    if e.keyCode == 37
      Navigation.active.goPrev()


window.addEventListener("load",init)
