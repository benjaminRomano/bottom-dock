class BottomDockService
  constructor: (@bottomDock) ->

  isActive: ->
    @bottomDock.active

  toggle: ->
    @bottomDock.toggle()

  changePane: (id) ->
    @bottomDock.changePane id

  deletePane: (id) ->
    @bottomDock.deletePane id

  getPane: (id) ->
    @bottomDock.getPane id

  addPane: (pane, title, isInitial) ->
    @bottomDock.addPane pane, title, isInitial

  getCurrentPane: ->
    @bottomDock.getCurrentPane()

  deleteCurrentPane: ->
    @bottomDock.deleteCurrentPane()

  onDidDeletePane: (callback) ->
    @bottomDock.onDidDeletePane callback

  onDidAddPane: (callback) ->
    @bottomDock.onDidAddPane callback

  onDidChangePane: (callback) ->
    @bottomDock.onDidChangePane callback

  onDidFinishResizing: (callback) ->
    @bottomDock.onDidFinishResizing callback

  onDidToggle: (callback) ->
    @bottomDock.onDidToggle callback
  
  paneCount: ->
    @bottomDock.paneCount()
  
module.exports = BottomDockService
