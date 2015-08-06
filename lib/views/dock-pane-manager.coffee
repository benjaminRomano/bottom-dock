{View, $} = require('space-pen')
{Emitter, CompositeDisposable} = require('atom')
crypto = require('crypto')

class DockPaneManager extends View
  @content: (params) ->
    @div class: 'pane-manager', =>
      @div outlet: 'resizeHandle', class: 'pane-manager-resize-handle'

  initialize: (params) ->
    @panes = []
    @currPane = null
    @subscriptions = new CompositeDisposable()
    @emitter = new Emitter()

    @handleEvents()

    if params and params.panes and params.panes.length
      for pane in params.panes
        @addPane(pane)

  addPane: (pane) ->
    @panes.push(pane)
    @append(pane)
    return pane

  changePane: (id) ->
    for pane in @panes
      if pane.getId() == String(id)
        pane.setActive(true)
        @currPane = pane
      else
        pane.setActive(false)

  refreshPane: (id) ->
    for pane in @panes
      if pane.getId() == String(id)
        pane.refresh()

  getPane: (id) ->
    return @panes.filter((p) ->
      p.getId() == String(id)
    )[0]

  getCurrentPane: ->
    return @currPane

  deletePane: (id) ->
    pane = @panes.filter((p) -> return p.getId() == String(id))[0]

    if not pane
      return false

    if @currPane.getId() == String(id)
      @currPane = null

    pane.destroy()

    @panes = @panes.filter((v) ->
      return v.getId() != String(id)
    )

    if not @currPane and @panes.length
      @changePane(@panes[@panes.length - 1].getId())

    return true

  resizeStarted: =>
    $(document).on('mousemove', @resizePane)
    $(document).on('mouseup', @resizeStopped)

  resizeStopped: =>
    $(document).off('mousemove', @resizePane)
    $(document).off('mouseup', @resizeStopped)

  resizePane: ({pageY, which}) ->
    height = $(document.body).height() - pageY
    $('.pane-manager').height(height)

  handleEvents: ->
    @on 'mousedown', '.pane-manager-resize-handle', (e) => @resizeStarted(e)

  destroy: ->
    @subscriptions.dispose()
    @resizeStopped()
    for pane in @panes
      pane.destroy()

module.exports = DockPaneManager
