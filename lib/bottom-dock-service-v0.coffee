{BasicTabButton} = require('atom-bottom-dock')

class BottomDockServiceV0
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
    config =
      name: name
      id: pane.getId()
      active: pane.isActive()

    tabButton = new BasicTabButton(config)
    @bottomDock.addPane(pane, tabButton)

  getCurrentPane: ->
    return @bottomDock.getCurrentPane()

  refreshCurrentPane: ->
    return @bottomDock.refreshCurrentPane()

  deleteCurrentPane: ->
    return @bottomDock.deleteCurrentPane()

  destroy: ->

module.exports = BottomDockServiceV0
