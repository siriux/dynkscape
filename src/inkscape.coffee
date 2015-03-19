
initInkscape = () ->
  setBackgroundColor()
  initInkscapeLayers()
  processDefaultInkscapeMetaDescs()

setBackgroundColor = () ->
  background = document.querySelector("svg namedview").getAttribute("pagecolor")
  # Create a really large centered rect as background
  bg = svgElement("rect")
  svgNode.appendChild(bg)
  setAttrs bg,
    id: "pageBackground"
    x: -50000
    y: -50000
    width: 100000
    height: 100000
    fill: background

initInkscapeLayers = () ->

  inkscapeLayersRecursive = (root, namespace) ->
    children = root.children("g")
    layers = children
      .filter (idx) -> children[idx].getAttribute("inkscape:groupmode") == "layer"
      .map (idx, l) ->
        name = l.getAttribute("inkscape:label")
        children = inkscapeLayersRecursive($(l), namespace + "." + name)
        new Layer(l, namespace, name, children)
    [].slice.call(layers)

  baseLayers = inkscapeLayersRecursive($("svg").first(), "layers")
  Layer.main = new Layer(svgNode, "layers", "__main__", baseLayers)

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
      classes = "AnimationObject #{meta.class}"
    else
      classes = "AnimationObject"

    if meta.type?
      classes = "#{classes} #{meta.type}"
    e.setAttribute("class", classes)

    metas.push([e, meta])

    aoIdx = metas.length - 1
    $(e).data("aoIdx", aoIdx)

  # Process __auto__ namespaces
  for [e, meta] in metas
    if meta.namespace == "__auto__"
      parent = $(e).parent().closest(".AnimationObject")
      parentIdx = parent.data("aoIdx")
      parentMeta = metas[parentIdx][1]
      # TODO Allow nested __auto__ namespaces
      meta.namespace = AnimationObject.createFullName(parentMeta.namespace, parentMeta.name)

  # Create the AnimationObjects
  for [e, meta] in metas
    ao = switch meta.type
      when "Navigation" then new Navigation(e, meta)
      when "Slide" then new Slide(e, meta)
      when "TextScroll" then new TextScroll(e, meta)
      when "Path" then new Path(e, meta)
      else new AnimationObject(e, meta)

    AnimationObject.objects.push(ao)

  # Init all AnimationObjects
  for ao in AnimationObject.objects
    ao.init()
