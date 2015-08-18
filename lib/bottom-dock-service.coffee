class BottomDockService
  constructor: (@bottomDock) ->

  toggle: ->
    @bottomDock.toggle()

  changePane: (id) ->
    @bottomDock.changePane id

  deletePane: (id) ->
    @bottomDock.deletePane id

  getPane: (id) ->
    return @bottomDock.getPane id

  addPane: (pane, title) ->
    @bottomDock.addPane pane, title

  getCurrentPane: ->
    return @bottomDock.getCurrentPane()

  deleteCurrentPane: ->
    return @bottomDock.deleteCurrentPane()

  onDidDeletePane: (callback) ->
    return @bottomDock.onDidDeletePane callback

  onDidChangePane: (callback) ->
    return @bottomDock.onDidChangePane callback

module.exports = BottomDockService
