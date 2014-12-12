
React = require 'react/addons'
cumulo = require 'cumulo-client'

AppMessage = require './message'
orders = require '../util/orders'

$ = React.DOM
cx = React.addons.classSet

module.exports = React.createFactory React.createClass
  displayName: 'thread-list'

  propTypes:
    user: React.PropTypes.object

  onMessageClick: (messageId) ->
    cumulo.send 'profile/changeThread', messageId

  renderMessages: ->
    @props.data.concat()
    .sort orders.timeReverse
    .map (message) =>
      onClick = => @onMessageClick message.id
      $.div
        key: message.id
        className: cx
          'outline': yes
          'is-inside': message.id is @props.user.thread
        onClick: onClick,
        AppMessage key: message.id, data: message

  render: ->

    $.div className: 'thread-list',
      @renderMessages()