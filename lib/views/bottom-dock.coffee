{CompositeDisposable, Emitter} = require('atom')
{View} = require('space-pen')
TabManager = require('./tab-manager')
DockPaneManager = require('./dock-pane-manager')
{BasicTabButton} = require('atom-bottom-dock')

class BottomDock extends View
  @content: (config) ->
    @div class: 'bottom-dock', =>
      @subview 'dockPaneManager', new DockPaneManager()
      @subview 'tabManager', new TabManager()

  initialize: (config) ->
    config = config ? {}
    @subscriptions = new CompositeDisposable()
    @panel = @createPanel startOpen: config.startOpen
    @emitter = new Emitter()

    @moveTabsToBottom config.tabsOnBottom

    @subscriptions.add(@tabManager.onTabClicked(@changePane.bind(@)))
    @subscriptions.add(@tabManager.onDeleteClicked(@deletePane.bind(@)))
    @subscriptions.add(@tabManager.onRefreshClicked(@refreshPane.bind(@)))
    @subscriptions.add(atom.config.observe('bottom-dock.tabsOnBottom', @moveTabsToBottom))

  onDidChangePane: (callback) ->
    return @emitter.on('pane:changed', callback)

  onDidDeletePane: (callback) ->
    return @emitter.on('pane:deleted', callback)

  moveTabsToBottom: (tabsOnBottom) =>
    if tabsOnBottom
      @dockPaneManager.insertBefore(@tabManager)
    else
      @tabManager.insertBefore(@dockPaneManager)

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
    @emitter.emit('pane:changed', id)

  refreshPane: (id) ->
    @dockPaneManager.refreshPane(id)

  deletePane: (id) ->
    success = @dockPaneManager.deletePane(id)
    if success
      @tabManager.deleteTab(id)
    @emitter.emit('pane:deleted', id)

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

  createPanel: ({startOpen}) ->
    options =
      item: this,
      visible: startOpen
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
