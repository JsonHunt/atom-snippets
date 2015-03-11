AtomSnippetsView = require './atom-snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomSnippets =
  atomSnippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomSnippetsView = new AtomSnippetsView(state.atomSnippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomSnippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomSnippetsView.destroy()

  serialize: ->
    atomSnippetsViewState: @atomSnippetsView.serialize()

  toggle: ->
    console.log 'AtomSnippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
