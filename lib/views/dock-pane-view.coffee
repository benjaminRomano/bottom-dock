{View} = require('space-pen')
$ = require('jquery')

class DockPaneView extends View
  initialize: ->
    @id = @generateId()

  #Remove this?
  setActive: (active) ->
    @active = active
    if @active
      @show()
    else
      @hide()

  isActive: ->
    return @active

  getId: ->
    return @id.split('dock-pane-')[1]

  refresh: ->

  destroy: ->
    @remove()

  generateId: ->
    possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

    text = ''
    for i in [0 .. 7]
      text += possible.charAt(Math.floor(Math.random() * possible.length))
    return 'dock-pane-' + text

module.exports = DockPaneView
