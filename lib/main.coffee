{CompositeDisposable} = require('atom')
BottomDockService = require('./bottom-dock-service')
BottomDockServiceV1 = require('./bottom-dock-service-v1')
BottomDockServiceV0 = require('./bottom-dock-service-v0')
BottomDock = require('./views/bottom-dock')

module.exports =
  config:
    startOpen:
      title: 'Start with Panel Open'
      type: 'boolean'
      default: false

  activate: ->
    config =
      startOpen: atom.config.get('bottom-dock.startOpen')

    @bottomDock = new BottomDock(config)
    @subscriptions = new CompositeDisposable()

    @subscriptions.add(atom.commands.add('atom-workspace',
      'bottom-dock:toggle': => @bottomDock.toggle()
    ))
    @subscriptions.add(atom.commands.add('atom-workspace',
      'bottom-dock:delete': => @bottomDock.deleteCurrentPane()
    ))

  provideBottomDockService: ->
    @bottomDockService = new BottomDockService(@bottomDock)

  provideBottomDockServiceV1: ->
    @bottomDockServiceV1 = new BottomDockServiceV1(@bottomDock)

  provideBottomDockServiceV0: ->
    @bottomDockServiceV0 = new BottomDockServiceV0(@bottomDock)

  deactivate: ->
    @subscriptions.dispose()
    @bottomDock.destroy()
