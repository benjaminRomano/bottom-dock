class BottomDockService
  constructor: (@bottomDock) ->

  toggle: ->
    @bottomDock.toggle()

  changePane: (id) ->
    @bottomDock.changePane(id)

  refreshPane: (id) ->
    @bottomDock.refreshPane(id)

  deletePane: (id) ->
    @bottomDock.deletePane(id)

  getPane: (id) ->
    return @bottomDock.getPane(id)

  addPane: (pane, tabButton) ->
    @bottomDock.addPane(pane, tabButton)

  getCurrentPane: ->
    return @bottomDock.getCurrentPane()

  refreshCurrentPane: ->
    return @bottomDock.refreshCurrentPane()

  deleteCurrentPane: ->
    return @bottomDock.deleteCurrentPane()

  onDidDeletePane: (callback) ->
    return @bottomDock.onDidDeletePane(callback)

  onDidChangePane: (callback) ->
    return @bottomDock.onDidChangePane(callback)

  destroy: ->

module.exports = BottomDockService
