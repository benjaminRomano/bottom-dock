{View} = require('space-pen')
{Emitter, CompositeDisposable} = require ('atom')
$ = require ('jquery')

class TabManager extends View
  @content: () ->
    @div class: 'tab-manager', =>
      @div outlet: 'viewButtonContainer', class: 'view-button-container', =>
        @span outlet: 'refreshButton', click: 'refreshClicked', class: 'refresh-button icon icon-sync'
        @span outlet: 'deleteButton', click: 'deleteClicked', class: 'delete-button icon icon-x'
      @div outlet: 'tabContainer', class: 'tab-container'

  initialize: () ->
    @tabs = []
    @subscriptions = new CompositeDisposable()
    @emitter = new Emitter()
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
