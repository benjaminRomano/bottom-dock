{View} = require('space-pen')
{Emitter, CompositeDisposable} = require ('atom')
$ = require ('jquery')

class TabManager extends View
  @content: () ->
    @div =>
      @div outlet: 'viewButtonContainer', =>
        @span outlet: 'refreshButton', click: 'refreshClicked'
        @span outlet: 'deleteButton', click: 'deleteClicked'
      @div outlet: 'tabContainer'

  initialize: () ->
    @tabs = []
    @subscriptions = new CompositeDisposable()
    @emitter = new Emitter()

    @addClass('tab-manager')
    @viewButtonContainer.addClass('view-button-container')
    @refreshButton.addClass('refresh-button icon icon-sync')
    @deleteButton.addClass('delete-button icon icon-x')
    @tabContainer.addClass('tab-container')

    @currTab = null

  addTab: (tab) ->
    @tabContainer.append(tab)
    @tabs.push(tab)

    @subscriptions.add(tab.onDidClick((id) =>
      @emitter.emit('tab:clicked', id)
    ))

  deleteTab: (id) ->
    tab = @tabs.filter((t) -> return t.getId() == String(id))[0]

    if not tab
      return

    if @currTab.getId() == String(id)
      @currTab = null

    tab.destroy()

    @tabs = @tabs.filter((t) -> t.getId() != String(id))

    if not @currTab && @tabs.length
      @changeTab(@tabs[@tabs.length - 1].getId())

  changeTab: (id) ->
    for tab in @tabs
      if tab.getId() == String(id)
        tab.setActive(true)
        @currTab = tab
      else
        tab.setActive(false)

  refreshClicked: =>
    if @currTab
      @emitter.emit('refresh:clicked', @currTab.getId())

  deleteClicked: =>
    if @currTab
      @emitter.emit('delete:clicked', @currTab.getId())

  onTabClicked: (callback) ->
    return @emitter.on('tab:clicked', callback)

  onRefreshClicked: (callback) ->
    return @emitter.on('refresh:clicked', callback)

  onDeleteClicked: (callback) ->
    return @emitter.on('delete:clicked', callback)

  deleteCurrentTab: ->
    @removeTab(@currTab.getId())

  destroy: ->
    @subscriptions.dispose()
    for tab in @tabs
      tab.destroy()

module.exports = TabManager
