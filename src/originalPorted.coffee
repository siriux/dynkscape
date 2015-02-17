### Original ported code

init = () ->
  s = Snap($("svg")[0])

  $("flowRoot").each (idx, root) ->
    rect = Snap(root).select("flowRegion > rect")

    fO = Snap(document.createElementNS("http://www.w3.org/2000/svg", "foreignObject"))

    fO.attr
      x: rect.attr("x")
      y: rect.attr("y")
      width: rect.attr("width")
      height: rect.attr("height")
      transform: $(root).attr("transform")

    div = $('<div xmlns="http://www.w3.org/1999/xhtml"></div>')
    div.attr("style", $(root).attr("style"))

    convertedHtml = root.innerHTML
      .replace(/<flowRegion.*flowRegion>/g,"")
      .replace(/http:\/\/www.w3.org\/2000\/svg/g,"http://www.w3.org/1999/xhtml")
      .replace(/flowPara/g,"div")
      .replace(/flowSpan/g,"span")

    div.html(convertedHtml)

    div.find("div").each (idx, d) ->
      if d.innerHTML == ""
        d.innerHTML = "\u200B"

    fO.append(div[0])

    $(root).replaceWith(fO.node)

window.addEventListener("load",init)

###
