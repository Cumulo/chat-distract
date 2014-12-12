
React = require 'react/addons'

$ = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'app-profile'

  render: ->

    $.div className: 'app-profile',
      'app-profile'