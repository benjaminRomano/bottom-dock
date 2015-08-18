{View, $} = require 'space-pen'
{Emitter, CompositeDisposable} = require 'atom'

class DockPaneManager extends View
  @content: (params) ->
    @div class: 'pane-manager'

  initialize: (params) ->
    @panes = []
    @currPane = null
    @subscriptions = new CompositeDisposable()
    @emitter = new Emitter()

    if params?.panes?.length
      @addPane pane  for pane in params.panes

  addPane: (pane) ->
    @panes.push pane
    @append pane

    # Adjust height when tab-manager is shown again
    if @panes.length == 2
      @height(@height() - $('.tab-manager').height())

    return pane

  changePane: (id) ->
    for pane in @panes
      if pane.getId() == String(id)
        pane.setActive true
        @currPane = pane
      else
        pane.setActive false

  getPane: (id) ->
    (pane for pane in @panes when pane.getId() == String(id))[0]

  getCurrentPane: ->
    return @currPane

  deletePane: (id) ->
    pane = (pane for pane in @panes when pane.getId() == String(id))[0]

    return false unless pane

    @currPane = null if @currPane.getId() == String(id)

    pane.destroy()

    @panes = (pane for pane in @panes when pane.getId() != String(id))

    if not @currPane and @panes.length
      @changePane @panes[@panes.length - 1].getId()


    # Adjust height when tab-manager is hidden
    if @panes.length == 1
      @height(@height() + $('.tab-manager').height())

    return true

  destroy: ->
    @subscriptions.dispose()
    pane.destroy() for pane in @panes

module.exports = DockPaneManager
