
React = require 'react/addons'
cumulo = require 'cumulo-client'

AppAvatar = require './avatar'

$ = React.DOM
cx = React.addons.classSet

module.exports = React.createFactory React.createClass
  displayName: 'app-message'

  propTypes:
    data: React.PropTypes.object
    onClick: React.PropTypes.func

  onPromote: ->
    cumulo.send 'message/setThread', @props.data.id

  onClick: ->
    @props.onClick?()

  render: ->

    $.div className: 'app-message', onClick: @onClick,
      AppAvatar
        data: @props.data.user
        size: 32, onClick: ->
      $.div className: 'body',
        $.div className: 'line',
          @props.data.user.nickname
          $.span className: 'time', @props.data.time
        $.div className: 'content',
          @props.data.text
        $.div
          className: cx
            'thread': yes
            'is-thread': @props.data.isThread
          onClick: @onPromote,
          '⑃'