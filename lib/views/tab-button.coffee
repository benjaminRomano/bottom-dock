{Emitter} = require('atom')
{View} = require('space-pen')

class TabButton extends View
  @content: (params) ->
    @button click: 'clicked'

  initialize: (config) ->
    @id = 'tab-button-' + config.id
    @addClass('btn')

    @text(config.name)
    @setActive(config.active)

    @emitter = new Emitter()

  clicked: =>
    @emitter.emit('tab:button:clicked', @getId())

  getId: ->
    return @id.split('tab-button-')[1]

  isActive: ->
    return @active

  setActive: (value) ->
    @active = value
    if @active
      @addClass('selected')
    else
      @removeClass('selected')

  onDidClick: (callback) ->
    return @emitter.on 'tab:button:clicked', callback

  destroy: ->
    @remove()

module.exports = TabButton
