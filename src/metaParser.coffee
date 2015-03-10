class MetaParser

  @mainGrammar = """
    start = line (nl line)* nl?

    line
      = d:indent pair (";" pair)* ";"? comment?
      / ws comment?

    pair = l:left ":" r:right { MetaParser._processMain(l,r) }

    indent = s:" "* { MetaParser._indent = s.length }

    notCommentChar =            !("//" / "/\\*") c:[^\\n]   { return c }
    notCommentOrColonChar =     !("//" / "/\\*") c:[^:\\n]  { return c }
    notCommentOrSemicolonChar = !("//" / "/\\*") c:[^;\\n]  { return c }

    left = c:notCommentOrColonChar+ { return c.join("") }

    right
      = c:notCommentOrSemicolonChar*  { return c.join("") }
      / '"' c:notCommentChar* '"'     { return c.join("") }

    ws = " "*
    nl = "\\n"


    comment
      = "//" [^\\n]*
      / "/\\*" (!"\\*/" .)* "\\*/"

    """

  @sideGrammar = """

  { var __res = {}; __res["__positionals"] = []; }

  start = positional? (ws positional)* named? (ws named)* { return __res }

  positional = !(id:id ws? "=") v:value { __res["__positionals"].push(v) }

  named = id:id ws? "=" ws? value:value { __res[id]=value }

  id = c:[a-zA-Z0-9_]+ { return c.join("") }

  value
    = c:[^ ="']+ { return c.join("") }
    / '"' c:contents '"' { return c }

  contents = c:[^"']+ { return c.join("") }

  ws = " "+

  """

  @mainParser = PEG.buildParser(@mainGrammar)

  @sideParser = PEG.buildParser(@sideGrammar)

  @parse: (meta, root={}) =>
    @_stack = [[-1, root]]
    MetaParser._parse(MetaParser.mainParser, meta)
    root

  @parseAnimation: (meta) => MetaParser.parse(meta, [])

  @_parse: (parser, string) =>
    try
      parser.parse(string)
    catch e
      console.log "Error parsing #{string}"
      console.log "At line #{e.line} char #{e.column}: #{e.message}"

  @_indent: 0

  @_processMain: (left, right) =>

    indent = MetaParser._indent
    current = @_stack[@_stack.length - 1]

    oudent = false
    while current[0] >= indent
      @_stack.pop()
      current = @_stack[@_stack.length - 1]
      outdent = true

    parent = current[1]

    inAnimations = parent instanceof Array
    key = $.trim(left)
    value = $.trim(right)

    if value.length == 0
      value = if key == "animations" or inAnimations then [] else {}
      @_stack.push([indent, value])
    else if not inAnimations
      # Try to parse as JSON values
      try
        value = JSON.parse(value)
      catch

    if inAnimations
      # ParseSides
      sp = MetaParser.sideParser
      l = MetaParser._parse(sp, key)
      r = if typeof value is "string" then MetaParser._parse(sp, value) else value
      parent.push([l, r])
    else
      # Clean values in objects
      parent[key] = value

# *********** #

metaOut = MetaParser.parse """
  asda:
    bar:
      xxx: 27
      zar: "35 \\n 45"

  as: dasd
  foo: true ; bar: 27.45
  animations:
    @click:
      / #objectA:
       - scale:  2  d=1.5 // A comment
       - rotate: 30 d=3 ; - translate: 10 20
      / #objectB o=300:
       - scale:  2 d=7 /* e=linear
       - rotate: 30 d=2.3 */
  """

animOut = MetaParser.parseAnimation "scale #foo: 2 3; rotate #bar: 25 d=37"

console.log JSON.stringify(metaOut, null, 2)
#console.log JSON.stringify(animOut, null, 2)
