
initInkscape = () ->
  initInkscapeLayers()
  createMainNavigation()
  processDefaultInkscapeMetaDescs()

createMainNavigation = () ->
  mainNavigation = svgElement("g")

  viewport = svgElement("rect")
  setAttrs viewport,
    x: -50000
    y: -50000
    width: 100000 + svgPageWidth
    height: 100000 + svgPageHeight
    fill: document.querySelector("svg namedview").getAttribute("pagecolor")
    class: "viewport"
  viewportDesc = svgElement("desc")
  viewportDesc.innerHTML = """
    # Meta
    namespace: __auto__
    name: viewport
    raw: true
  """
  viewport.appendChild(viewportDesc)
  mainNavigation.appendChild(viewport)

  control = $("#mainNavigation")[0]

  desc = $(control).find("desc")[0]
  mainNavigation.appendChild(desc)

  control.setAttribute("class", "navigationControl")
  m = actualMatrix(control)
  setTransform(control, m)
  mainNavigation.appendChild(control)

  svgNode.appendChild(mainNavigation)

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

  mainLayerEl = svgElement("g")
  svgNode.appendChild(mainLayerEl)
  for l in baseLayers
    mainLayerEl.appendChild(l.element)

  Layer.main = new Layer(mainLayerEl, "layers", "__main__", baseLayers)

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
