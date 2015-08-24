{Emitter} = require 'atom'
{View, $} = require 'space-pen'

class Header extends View
  @content: (title) ->
    @div class: 'bottom-dock-header', =>
      @div outlet: 'resizeHandle', class: 'dock-resize-handle'
      @span outlet: 'title', class: 'title'
      @div outlet: 'buttonContainer', class: 'button-container', =>
        @span outlet: 'deleteButton', click: 'deleteClicked', class: 'delete-button icon icon-x'

  deleteClicked: =>
    @emitter.emit 'header:delete:clicked'

  setTitle: (title) =>
    @title.text title

  initialize: (title) ->
    @setTitle title if title?
    @handleEvents()
    @emitter = new Emitter()

  onDidClickDelete: (callback) ->
    @emitter.on 'header:delete:clicked', callback

  resizeStarted: =>
    $(document).on 'mousemove', @resizePane
    $(document).on 'mouseup', @resizeStopped

  resizeStopped: =>
    $(document).off 'mousemove', @resizePane
    $(document).off 'mouseup', @resizeStopped
    @emitter.emit 'header:resize:finished'

  onDidFinishResizing: (callback) =>
    @emitter.on 'header:resize:finished', callback

  resizePane: ({pageY, which}) ->
    height = $(document.body).height() - pageY - $('.tab-manager').height() - $('.bottom-dock-header').height()
    height -= $('.status-bar').height() if $('.status-bar')

    $('.pane-manager').height(height)
    $('.pane-manager').trigger 'update'
    $('.pane-manager').on 'update', ->

  handleEvents: ->
    @on 'mousedown', '.dock-resize-handle', (e) => @resizeStarted e

  destroy: ->
    @resizeStopped()
    @remove()

module.exports = Header
