class BottomDockServiceV0
  constructor: (@bottomDock) ->

  toggle: ->
    @bottomDock.toggle()

  changePane: (id) ->
    @bottomDock.changePane id

  refreshPane: (id) ->

  deletePane: (id) ->
    @bottomDock.deletePane id

  getPane: (id) ->
    return @bottomDock.getPane id

  addPane: (pane, title) ->
    tabConfig =
      title: title
      active: true
      id: pane.getId()

    @bottomDock.addPane pane, tabConfig

  getCurrentPane: ->
    return @bottomDock.getCurrentPane()

  refreshCurrentPane: ->

  deleteCurrentPane: ->
    return @bottomDock.deleteCurrentPane()

module.exports = BottomDockServiceV0
