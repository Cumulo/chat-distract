
React = require 'react'

AppAvatar = require './avatar'

$ = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'app-typing'

  propTypes:
    data: React.PropTypes.object

  render: ->

    $.div className: 'app-typing',
      AppAvatar
        data: @props.data.user
        size: 32, onClick: ->
      $.div className: 'body',
        $.div className: 'line',
          @props.data.user.nickname
          $.span className: 'time', @props.data.textTime
        $.div className: 'content',
          @props.data.text