{CompositeDisposable} = require('atom')
BottomDockService = require('./bottom-dock-service')
BottomDock = require('./views/bottom-dock')

module.exports =
  activate: (state) ->
    @bottomDockService = new BottomDockService(new BottomDock())
    @subscriptions = new CompositeDisposable()

    @subscriptions.add(atom.commands.add('atom-workspace',
      'bottom-dock:toggle': => @bottomDockService.toggle()
    ))
    @subscriptions.add(atom.commands.add('atom-workspace',
      'bottom-dock:delete': => @bottomDockService.deleteCurrentPane()
    ))
    @subscriptions.add(atom.commands.add('atom-workspace',
      'bottom-dock:refresh': => @bottomDockService.refreshCurrentPane()
    ))

  provideBottomDock: () ->
    return @bottomDockService

  deactivate: ->
    @subscriptions.dispose()
    @bottomDockService.destroy()
