{View, $} = require 'space-pen'
{Emitter, CompositeDisposable} = require 'atom'
TabButton = require './tab-button'

class TabManager extends View
  @content: () ->
    @div class: 'tab-manager', =>
      @div outlet: 'tabContainer', class: 'tab-container'

  initialize: () ->
    @tabs = []
    @subscriptions = new CompositeDisposable()
    @emitter = new Emitter()
    @currTab = null

  getCurrentTabTitle: ->
    @currTab?.title ? ""

  addTab: (config) ->
    tab = new TabButton config
    @tabContainer.append tab
    @tabs.push tab

    if @tabs.length == 1
      @hide()
    else
      @show()

    @subscriptions.add tab.onDidClick (id) =>
      @emitter.emit 'tab:clicked', id

  deleteTab: (id) ->
    matchedTabs = (tab for tab in @tabs when tab.getId() == String(id))
    matchedTab = matchedTabs[0]

    return unless matchedTab

    if @currTab.getId() == String(id)
      @currTab = null

    matchedTab.destroy()

    @tabs = (tab for tab in @tabs when tab.getId() != String(id))

    if not @currTab && @tabs.length
      @changeTab @tabs[@tabs.length - 1].getId()

    if @tabs.length == 1 then @hide() else @show()

  changeTab: (id) ->
    for tab in @tabs
      if tab.getId() == String(id)
        tab.setActive true
        @currTab = tab
      else
        tab.setActive false

  deleteClicked: =>
    if @currTab
      @emitter.emit 'delete:clicked', @currTab.getId()

  onTabClicked: (callback) ->
    @emitter.on 'tab:clicked', callback

  onDeleteClicked: (callback) ->
    @emitter.on 'delete:clicked', callback

  deleteCurrentTab: ->
    @removeTab @currTab.getId()

  destroy: ->
    @subscriptions.dispose()
    tab.destroy for tab in @tabs

module.exports = TabManager
