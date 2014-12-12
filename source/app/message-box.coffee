
React = require 'react/addons'
cumulo = require 'cumulo-client'

$ = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'message-box'

  getInitialState: ->
    text: ''

  onTextChange: (event) ->
    text = event.target.value
    @setState text: text
    cumulo.send 'preview/text', @state.text

  onTextSubmit: ->
    cumulo.send 'message/create', @state.text
    cumulo.send 'preview/remove'
    @setState text: ''

  onTextKeydown: (event) ->
    if event.keyCode is 13 # return
      event.preventDefault()
      @onTextSubmit()

  render: ->

    $.div className: 'message-box',
      $.textarea
        className: 'text'
        onChange: @onTextChange
        onKeyDown: @onTextKeydown
        value: @state.text
        placeholder: '按下回车发布消息'