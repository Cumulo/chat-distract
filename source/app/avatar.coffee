
React = require 'react/addons'

$ = React.DOM
T = React.PropTypes

module.exports = React.createFactory React.createClass
  displayName: 'app-avatar'

  propTypes:
    data: T.object
    size: T.number
    onClick: T.func

  onClick: ->
    @props.onClick()

  render: ->
    style =
      width: "#{@props.size}px"
      height: "#{@props.size}px"
      backgroundImage: "url('#{@props.data.avatar}')"
    $.div
      className: 'app-avatar'
      style: style
      onClick: @onClick
      title: @props.data.nickname