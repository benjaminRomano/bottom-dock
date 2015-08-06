{CompositeDisposable} = require('atom')
{View} = require('space-pen')
TabManager = require('./tab-manager')
DockPaneManager = require('./dock-pane-manager')
{BasicTabButton} = require('atom-bottom-dock')

class BottomDock extends View
  @content: (params) ->
    @div class: 'bottom-dock', =>
      @subview 'tabManager', new TabManager()
      @subview 'dockPaneManager', new DockPaneManager()

  initialize: (@state) ->
    @subscriptions = new CompositeDisposable()
    @panel = @createPanel()

    @subscriptions.add(@tabManager.onTabClicked(@changePane.bind(@)))
    @subscriptions.add(@tabManager.onDeleteClicked(@deletePane.bind(@)))
    @subscriptions.add(@tabManager.onRefreshClicked(@refreshPane.bind(@)))

  addPane: (pane, tabButton) ->
    @dockPaneManager.addPane(pane)
    @tabManager.addTab(tabButton)

    if pane.isActive()
      @changePane(pane.getId())
    else
      tabButton.setActive(false)

  getPane: (id) ->
    @dockPaneManager.getPane(id)

  getCurrentPane: ->
    @dockPaneManager.getCurrentPane()

  changePane: (id) ->
    @dockPaneManager.changePane(id)
    @tabManager.changeTab(id)

  refreshPane: (id) ->
    @dockPaneManager.refreshPane(id)

  deletePane: (id) ->
    success = @dockPaneManager.deletePane(id)
    if success
      @tabManager.deleteTab(id)

  deleteCurrentPane: ->
    currentPane = @dockPaneManager.getCurrentPane()
    if not currentPane
      return

    @deletePane(currentPane.getId())

  refreshCurrentPane: ->
    currentPane = @dockPaneManager.getCurrentPane()
    if not currentPane
      return

    @refreshPane(currentPane.getId())

  createPanel: ->
    options =
      item: this,
      visible: true,
      priority: 1000

    return atom.workspace.addBottomPanel(options)

  toggle: ->
    if @panel.isVisible()
      @panel.hide()
    else
      @panel.show()

  destroy: ->
    @subscriptions.dispose()
    @panel.destroy()
    @tabManager.destroy()
    @dockPaneManager.destroy()

module.exports = BottomDock
