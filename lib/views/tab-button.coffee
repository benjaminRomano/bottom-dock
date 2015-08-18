{Emitter} = require 'atom'
{View} = require 'space-pen'

class TabButton extends View
  @content: (config) ->
    @button click: 'clicked', class: 'tab-button', config.title

  clicked: =>
    @emitter.emit 'tab:button:clicked', @getId()

  initialize: (config) ->
    @title = config.title
    @id = "tab-button-#{config.id}"
    @setActive config.active

    @emitter = new Emitter()

  getId: ->
    @id.split('tab-button-')[1]

  isActive: ->
    @active

  setActive: (value) ->
    @active = value
    if @active
      @addClass 'selected'
    else
      @removeClass 'selected'

  onDidClick: (callback) ->
    @emitter.on 'tab:button:clicked', callback

  destroy: ->
    @remove()

module.exports = TabButton
