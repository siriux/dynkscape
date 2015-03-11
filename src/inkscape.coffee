
initInkscape = () ->
  setBackgroundColor()
  initInkscapeLayers()
  processDefaultInkscapeMetaDescs()

setBackgroundColor = () ->
  background = Snap("svg namedview").attr("pagecolor")
  # Create a really large centered rect as background
  bg = sSvg.paper.rect(-50000, -50000, 100000, 100000)
  bg.attr('fill', background)

initInkscapeLayers = () ->

  inkscapeLayersRecursive = (root, namespace) ->
    layers = root
      .children("g")
      .filter (idx, g) -> g.getAttribute("inkscape:groupmode") == "layer"
      .map (idx, l) ->
        name = l.getAttribute("inkscape:label")
        children = inkscapeLayersRecursive($(l), namespace + "." + name)
        new Layer(l, namespace, name, children)
    $.makeArray(layers)

  baseLayers = inkscapeLayersRecursive($("svg").first(), "layers")
  Layer.main = new Layer(sSvg.node, "layers", "__main__", baseLayers)

processInkscapeMetaDescs = (base, callback) ->
  $(base).find("desc").each (idx, d) ->
    text = $(d).text()
    m = text.match /[\s\S]*#\s*meta\s*\n([\s\S]*)/i
    if m?
      meta = m[1]
      try
        doc = MetaParser.parse(meta)
      catch e # Ignore non meta descs
        console.log "Error parsing meta: #{meta}"
        throw e
      parent = d.parentNode
      callback(parent, doc)

processDefaultInkscapeMetaDescs = () ->
  # Get metas and add classes
  metas = []
  processInkscapeMetaDescs document, (e, meta) ->
    if meta.class?
      classes = meta.class.split(" ")
    else
      classes = []

    classes.push("AnimationObject")

    Snap(e).addClass(classes.join(" "))

    metas.push([e, meta, classes])

    aoIdx = metas.length - 1
    $(e).data("aoIdx", aoIdx)

  # Process __auto__ namespaces
  for [e, meta, classes] in metas
    if meta.namespace == "__auto__"
      parent = $(e).parent().closest(".AnimationObject")
      parentIdx = parent.data("aoIdx")
      parentMeta = metas[parentIdx][1]
      # TODO Allow nested __auto__ namespaces
      meta.namespace = AnimationObject.createFullName(parentMeta.namespace, parentMeta.name)

  # Create the AnimationObjects
  for [e, meta, classes] in metas
    if "Navigation" in classes
      o = new Navigation(e, meta)

    else if "Slide" in classes
      o = new Slide(e, meta)

    else if "TextScroll" in classes
      o = new TextScroll(e, meta)

    else
      o = new AnimationObject(e, meta)

    AnimationObject.objects.push(o)

  # Init all AnimationObjects
  for ao in AnimationObject.objects
    ao.init()
