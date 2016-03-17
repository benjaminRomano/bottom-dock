{Emitter} = require 'atom'
{View, $} = require 'space-pen'

class Status extends View
  @content: (config) ->
    @div class: 'bottom-dock-status-container inline-block', style: 'display: inline-block', =>
      @span outlet: 'visibilityIcon', class: 'visibility-icon icon icon-eye'
      @span outlet: 'countText'

  initialize: (config) ->
    @emitter = new Emitter

    @setVisiblity config.visible
    @updateCount config.paneCount
    @setBottomDockVisibility config.bottomDockVisible

    @on 'click', @toggleClicked

  updateCount: (count) =>
    @countText.text "Bottom Dock (#{count})"

  setBottomDockVisibility: (value) =>
    if value and not @visibilityIcon.hasClass 'active'
      @visibilityIcon.addClass 'active'
    else
      @visibilityIcon.removeClass 'active'

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
