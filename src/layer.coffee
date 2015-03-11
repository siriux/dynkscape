class Layer extends AnimationObject

  @main: null

  constructor: (element, namespace, name, @children) ->
    super(element, (namespace: namespace, name: name), svgPageWidth, svgPageHeight, true) # Raw

    @parent = null
    @slidesLayer = null
    @animationLayer = null

    @isSlides = false
    if name.match(/^Slides.*/i)
      @isSlides = true

    @isAnimation = false
    if name.match(/^Animation.*/i)
      @isAnimation = true

    # Link to children
    for c in @children
      c.parent = this

      if c.isSlides
        @slidesLayer = c

      if c.isAnimation
        @animationLayer = c

    @animationLayer?.hide() # Animation layers are hidden by default

    @init() # Init directly

  isMain: () => @fullName == "layers.__main__"

  show: () => $(@element).show()

  hide: () => $(@element).hide()
