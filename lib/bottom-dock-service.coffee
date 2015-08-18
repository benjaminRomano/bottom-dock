class BottomDockService
  constructor: (@bottomDock) ->

  toggle: ->
    @bottomDock.toggle()

  changePane: (id) ->
    @bottomDock.changePane id

  deletePane: (id) ->
    @bottomDock.deletePane id

  getPane: (id) ->
    @bottomDock.getPane id

  addPane: (pane, title) ->
    @bottomDock.addPane pane, title

  getCurrentPane: ->
    @bottomDock.getCurrentPane()

  deleteCurrentPane: ->
    @bottomDock.deleteCurrentPane()

  onDidDeletePane: (callback) ->
    @bottomDock.onDidDeletePane callback

  onDidChangePane: (callback) ->
    @bottomDock.onDidChangePane callback

module.exports = BottomDockService
