
React = require 'react'

App = React.createClass
  render: ->
    React.DOM.div {}, 'dev'

React.renderComponent App(), document.body