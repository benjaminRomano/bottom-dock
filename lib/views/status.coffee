{Emitter} = require 'atom'
{View, $} = require 'space-pen'

class Status extends View
  @content: (config) ->
    @div class: 'bottom-dock-status-container inline-block', style: 'display: inline-block', =>
      @span 'Bottom Dock'

  initialize: (config) ->
    @emitter = new Emitter

    @setVisiblity config.visible

    @on 'click', @toggleClicked


  setVisiblity: (value) =>
    if value
      @show()
    else
      @hide()

  toggleClicked: =>
    @emitter.emit 'status:toggled'

  onDidToggle: (callback) ->
    @emitter.on 'status:toggled', callback

module.exports = Status
