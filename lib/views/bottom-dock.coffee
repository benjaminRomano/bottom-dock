{CompositeDisposable, Emitter} = require 'atom'
{View} = require 'space-pen'
TabManager = require './tab-manager'
DockPaneManager = require './dock-pane-manager'
Header = require './header'

class BottomDock extends View
  @content: (config) ->
    @div class: 'bottom-dock', =>
      @subview 'header', new Header()
      @subview 'dockPaneManager', new DockPaneManager()
      @subview 'tabManager', new TabManager()

  initialize: (config) ->
    config = config ? {}
    @subscriptions = new CompositeDisposable()
    @panel = @createPanel startOpen: config.startOpen
    @emitter = new Emitter()

    @subscriptions.add @tabManager.onTabClicked @changePane
    @subscriptions.add @tabManager.onDeleteClicked @deletePane
    @subscriptions.add @header.onDidClickDelete @deleteCurrentPane

  onDidFinishResizing: (callback) ->
    @header.onDidFinishResizing callback

  onDidChangePane: (callback) ->
    @emitter.on 'pane:changed', callback

  onDidDeletePane: (callback) ->
    @emitter.on 'pane:deleted', callback

  addPane: (pane, title) ->
    @panel.show()
    @dockPaneManager.addPane pane

    config =
      title: title
      id: pane.getId()

    @tabManager.addTab config

    if pane.isActive()
      @changePane pane.getId()
    else
      tabButton.setActive false

  getPane: (id) ->
    @dockPaneManager.getPane id

  getCurrentPane: ->
    @dockPaneManager.getCurrentPane()

  changePane: (id) =>
    @dockPaneManager.changePane id
    @tabManager.changeTab id
    @header.setTitle @tabManager.getCurrentTabTitle()
    @emitter.emit 'pane:changed', id

  deletePane: (id) =>
    success = @dockPaneManager.deletePane id
    return unless success

    @tabManager.deleteTab id

    if @dockPaneManager.getCurrentPane()
      @header.setTitle @tabManager.getCurrentTabTitle()
    else
      @panel.hide()

    @emitter.emit 'pane:deleted', id

  deleteCurrentPane: =>
    currentPane = @dockPaneManager.getCurrentPane()
    return unless currentPane

    @deletePane currentPane.getId()

  createPanel: ({startOpen}) ->
    options =
      item: this,
      visible: startOpen
      priority: 1000

    return atom.workspace.addBottomPanel options

  toggle: ->
    if not @panel.isVisible() and @dockPaneManager.getCurrentPane()
      @panel.show()
    else
      @panel.hide()

  destroy: ->
    @subscriptions.dispose()
    @panel.destroy()
    @header.destroy()
    @tabManager.destroy()
    @dockPaneManager.destroy()

module.exports = BottomDock
