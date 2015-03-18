documentState = null

ensureDocumentState = () ->
 if not documentState?
   documentState = {}
   window.history.pushState("", document.title, window.location.pathname + "#restore")

clearDocumentState = () -> documentState = null

_ensureAndGetReferenceState = (reference) ->
  ensureDocumentState()
  refStates = documentState[reference]
  if not refStates?
    refStates =
      idx: 0
      states: [{}]
    documentState[reference] = refStates
  refStates

newReferenceState = (reference, state = {}) ->
  refStates = _ensureAndGetReferenceState(reference)
  refStates.states = refStates.states[0..refStates.idx]
  refStates.states.push(state)
  refStates.idx += 1

undoReferenceState = (reference) ->
  refStates = documentState?[reference]
  if refStates? and refStates.idx > 0
    refStates.idx -= 1
    applyCurrentState([reference])

redoReferenceState = (reference) ->
  refStates = documentState?[reference]
  if refStates? and refStates.idx < (refStates.states.length - 1)
    refStates.idx += 1
    applyCurrentState([reference])

updateReferenceState = (reference, updateFunction) ->
  refStates = _ensureAndGetReferenceState(reference)
  current = refStates.states[refStates.idx]
  updateFunction(current)

getCurrentReferenceState = (reference) ->
  refStates = documentState?[reference]
  if refStates?
    state = {}
    for s in refStates.states[0..refStates.idx]
      $.extend(true, state, s) # Deep extend
    state

applyCurrentReferenceState = (reference, skipAnimation = false) ->
  s = getCurrentReferenceState(reference)
  if s?
    o = getObjectFromReference("", reference)
    o?.applyReferenceState(s, skipAnimation)

applyDocumentState = (skipAnimation = false) ->
  if documentState?
    for k, v of documentState
      applyCurrentReferenceState(k, skipAnimation)

saveDocumentState = () ->
  if documentState?
    stateString = JSON.stringify(documentState)
    localStorage.setItem("documentState", stateString)

loadDocumentState = () ->
  stateString = localStorage.getItem("documentState")

  if stateString?
    try
      documentState = JSON.parse(stateString)
    catch

  if documentState?
    applyDocumentState(true)

saveEmptyDocumentState = () ->
  localStorage.setItem("documentState", "{}")
