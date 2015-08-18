class BottomDockServiceV1
  constructor: (@bottomDock) ->

  toggle: ->
    @bottomDock.toggle()

  changePane: (id) ->
    @bottomDock.changePane id

  refreshPane: (id) ->

  deletePane: (id) ->
    @bottomDock.deletePane id

  getPane: (id) ->
    @bottomDock.getPane id

  addPane: (pane, tabButton) ->
    # Cannot extract title from tabButton using id instead
    @bottomDock.addPane pane, pane.getId()

  getCurrentPane: ->
    @bottomDock.getCurrentPane()

  refreshCurrentPane: ->

  deleteCurrentPane: ->
    @bottomDock.deleteCurrentPane()

  onDidDeletePane: (callback) ->
    @bottomDock.onDidDeletePane callback

  onDidChangePane: (callback) ->
    @bottomDock.onDidChangePane callback

module.exports = BottomDockServiceV1
