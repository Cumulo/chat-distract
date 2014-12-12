
React = require 'react'

$ = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'module-tip'

  propTypes:
    data: React.PropTypes.object.isRequired
    onClick: React.PropTypes.func.isRequired

  onClick: ->
    @props.onClick @props.data.id

  render: ->

    $.div className: 'module-tip', onClick: @onClick,
      @props.data.text