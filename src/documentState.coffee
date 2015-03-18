documentStateStack = []

lastDocumentState = () -> documentStateStack[documentStateStack.length - 1]

clearDocumentState = () ->
  documentStateStack.length = 0

newDocumentState = () -> documentStateStack.push {}

# TODO Redo? What would be the semantic?
# When to clean redo?
#  Clean for reference on updateReferenceCurrentState
#  Clean all on newDocumentState
# ???
undoDocumentState = (reference) ->
  if reference?
    for s in documentStateStack by -1
      if s[reference]?
        delete s[reference]
        break
    applyCurrentState([reference])
  else
    curr = documentStateStack.pop()
    applyCurrentState(Object.keys(curr))

updateReferenceCurrentState = (reference, updateFunction) ->
  curr = lastDocumentState()
  s = curr[reference]
  if not s?
    s = {}
    curr[reference] = s
  updateFunction(s)

getStateForReference = (reference) ->
  state = {}
  for s in documentStateStack
    partialState = s[reference]
    if partialState?
      $.extend(true, state, partialState) # Deep extend
  state

applyCurrentState = (references) ->
  if not references?
    references = []
    for s in documentStateStack
      references = references.contact(Object.keys(s))

  for ref in references
    s = getStateForReference(ref)
    o = getObjectFromReference(ref)
    o.goToState(s)

saveDocumentStateStack = () ->
  stateString = JSON.stringify(documentStateStack)
  localStorage.setItem("documentStateStack", stateString)

loadDocumentStateStack = () ->
  stateString = localStorage.getItem("documentStateStack")
  if stateString?
    documentStateStack = JSON.parse(stateString)

saveEmptyDocumentState = () ->
  localStorage.setItem("documentStateStack", "[]")

$(window).unload () -> saveDocumentStateStack()

# Init
loadDocumentStateStack()
if documentStateStack.length == 0
  newDocumentState()
