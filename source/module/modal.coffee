
React = require 'react/addons'

$ = React.DOM
T = React.PropTypes

module.exports = React.createFactory React.createClass
  displayName: 'module-modal'

  propTypes:
    # accepts children
    onClose: T.func

  onClick: (event) ->
    if event.target.className is 'module-modal'
      @props.onClose()

  render: ->

    $.div className: 'module-modal', onClick: @onClick,
      $.div className: 'box',
        @props.children