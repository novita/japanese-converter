JapaneseConverterView = require './japanese-converter-view'
{CompositeDisposable} = require 'atom'

module.exports = JapaneseConverter =
  japaneseConverterView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @japaneseConverterView = new JapaneseConverterView(state.japaneseConverterViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @japaneseConverterView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'japanese-converter:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @japaneseConverterView.destroy()

  serialize: ->
    japaneseConverterViewState: @japaneseConverterView.serialize()

  toggle: ->
    console.log 'JapaneseConverter was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
