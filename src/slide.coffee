class Slide extends AnimationObject
  constructor: (element, meta) ->
    super(element, meta)

    # Style
    #TODO Another rect to avoid problems with border?
    setStyle @origElement,
      fill: "#777"
      "fill-opacity": 0.4

    x = getFloatAttr(@origElement, "x", 0)
    y = getFloatAttr(@origElement, "y", 0)

    t = svgElement("text")
    t.appendChild(document.createTextNode(@index.toString()))
    @element.appendChild(t)
    setAttrs t,
      x: x + @width*0.5
      y: y + @height*0.5
      dy: ".3em"

    setStyle t,
      "text-anchor": "middle"
      "font-family": "Arial"
      "font-size": @width * 0.5
      fill: "#fff"
      "fill-opacity": 0.8
