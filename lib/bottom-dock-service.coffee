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

  addPane: (pane, name) ->
    @bottomDock.addPane(pane, name)

  getCurrentPane: ->
    return @bottomDock.getCurrentPane()

  refreshCurrentPane: ->
    return @bottomDock.refreshCurrentPane()

  deleteCurrentPane: ->
    return @bottomDock.deleteCurrentPane()

  destroy: ->
    @bottomDock.destroy()

module.exports = BottomDockService
