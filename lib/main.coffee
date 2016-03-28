{CompositeDisposable} = require 'atom'
BottomDockService = require './bottom-dock-service'
BottomDockServiceV1 = require './bottom-dock-service-v1'
BottomDockServiceV0 = require './bottom-dock-service-v0'
BottomDock = require './views/bottom-dock'
Status = require './views/status'

module.exports =
  config:
    showStatus:
      title: 'Show pane count in status bar'
      type: 'boolean'
      default: true
    startOpen:
      title: 'Start with panel open'
      type: 'boolean'
      default: false

  activate: ->
    config =
      startOpen: atom.config.get 'bottom-dock.startOpen'

    @bottomDock = new BottomDock config
    @subscriptions = new CompositeDisposable()

    # Subscribe to keybindings
    @subscriptions.add atom.commands.add 'atom-workspace',
      'bottom-dock:toggle': => @bottomDock.toggle()
    @subscriptions.add atom.commands.add 'atom-workspace',
     'bottom-dock:delete': => @bottomDock.deleteCurrentPane()

    # Subscribe to config for status visiblity
    @subscriptions.add atom.config.onDidChange 'bottom-dock.showStatus', ({newValue}) =>
      @statusBarTile?.item.setVisiblity newValue

  consumeStatusBar: (statusBar) ->
    
    config =
      visible: atom.config.get 'bottom-dock.showStatus'

    @statusBarTile = statusBar.addRightTile item: new Status config , priority: 2

    @subscriptions.add @statusBarTile.item.onDidToggle => @bottomDock.toggle()

  provideBottomDockService: ->
    @bottomDockService = new BottomDockService @bottomDock

  provideBottomDockServiceV1: ->
    @bottomDockServiceV1 = new BottomDockServiceV1 @bottomDock

  provideBottomDockServiceV0: ->
    @bottomDockServiceV0 = new BottomDockServiceV0 @bottomDock

  deactivate: ->
    @subscriptions.dispose()
    @bottomDock.destroy()
    @statusBarTile?.destroy()
    @statusBarTile = null
