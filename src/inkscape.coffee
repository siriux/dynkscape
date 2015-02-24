inkscapeLayersByName = {}
mainLayer = null

class Layer
  constructor: (@name, @element, @children) ->
    @parent = null
    @slidesLayer = null

    # Find the Slides layer
    for l in @children
      if l.name.match(/^Slides.*/i)
        @slidesLayer = l
        break

    # Slide layers are hidden by default
    if @slidesLayer?
      $(@slidesLayer.element).hide()

initInkscape = () ->
  initInkscapeLayers()
  processDefaultInkscapeMetaDescs()
  setBackgroundColor()

setBackgroundColor = () ->
  background = Snap("svg namedview").attr("pagecolor")
  # Create a really large centered rect as background
  bg = sSvg.paper.rect(-50000, -50000, 100000, 100000)
  bg.attr('fill', background)

initInkscapeLayers = () ->

  inkscapeLayersRecursive = (root) ->
    layers = root
      .children("g")
      .filter (idx, g) -> g.getAttribute("inkscape:groupmode") == "layer"
      .map (idx, l) ->
        name = l.getAttribute("inkscape:label")
        children = inkscapeLayersRecursive($(l))

        layer = new Layer(name, l, children)

        # Link to children
        c.parent = layer for c in children

        # Add layer by name
        inkscapeLayersByName[name] = layer

        layer
    $.makeArray(layers)

  baseLayers = inkscapeLayersRecursive($("svg").first())
  mainLayer = new Layer("", sSvg.node, baseLayers)

processInkscapeMetaDescs = (base, callback) ->
  $(base).find("desc").each (idx, d) ->
    text = $(d).text()
    if text.match /^\s*#\s*meta/i
      try
        doc = jsyaml.load(text)
        parent = d.parentNode
        callback(parent, doc)
      catch # Ignore non meta descs
        # TODO Show errors to the user?

processDefaultInkscapeMetaDescs = () ->
  processInkscapeMetaDescs document, (e, meta) ->
    if meta.toggle?
      processToggle(e, meta)

    if meta.class?
      Snap(e).addClass(meta.class)

    if meta.hasOwnProperty('hidden') && meta.hidden != false
      $(e).hide()

    if meta.viewport?
      processViewport(e, meta)

processToggle = (e, meta) ->

  $el = null # The element to toggle

  if meta.toggle.charAt(0) != "#"
    # Treat as a layer name
    l = inkscapeLayersByName[meta.toggle]
    $el = $(l.element)
  else
    # Treat as an object ID
    $el = $(meta.toggle)

  return if $el.length != 1 # Element not found, ignore

  cues = null

  hide = () ->
    $el.hide()
    for c in cues
      c.animate(transform: "r0 t0,0", 100, mina.easein)

  show = () ->
    $el.show()
    for c in cues
      c.animate(transform: "r45 t0,0", 100, mina.easein)

  initToggle = () ->
    cues = for c in Snap(e).selectAll(".toggleCue")
      # Wrap a group around contents, this group can be easily transformed
      g = sSvg.g()
      $(g.node).append($(c.node).contents())
      c.add(g)
      g

    if meta.toggleStartHidden == true
      hide()
    else
      show()

  setTimeout initToggle, 0 # Delay the init until all the meta is processed

  $(e).click () ->
    if $el.css("display") != "inline" # Hidden element
      show()
    else
      hide()

processViewport = (e, meta) ->
  initViewport = () ->
    viewEl = $(e).find(".viewport")[0]

    mv = meta.viewport

    userNavigation = mv.hasOwnProperty('userNavigation') && mv.userNavigation != false

    n = new Navigation(mv.layer, viewEl, userNavigation)

    animate = mv.animate

    if animate?
      animate.easing = getEasing(animate.easing)

    if mv.start?
      n.goTo(mv.start)

    $(e).find(".prev").click () => n.goPrev(animate)

    $(e).find(".next").click () => n.goNext(animate)

  setTimeout initViewport, 0 # Delay the init until all the meta is processed
