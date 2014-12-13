
React = require 'react/addons'
cumulo = require 'cumulo-client'

session = cumulo.session
$ = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'app-login'

  getInitialState: ->
    name: ''
    password: ''

  onNameChange: (event) ->
    @setState name: event.target.value

  onPasswordChange: (event) ->
    @setState password: event.target.value

  onSubmit: ->
    data =
      name: @state.name
      password: @state.password
    cumulo.send 'account/login', data
    session.set data

  render: ->

    $.div className: 'app-login paragraph',
      $.input
        className: 'name', type: 'text'
        value: @state.name, placeholder: '用户名'
        onChange: @onNameChange
      $.input
        className: 'password', type: 'text'
        onChange: @onPasswordChange
        value: @state.password, placeholder: '密码'
      $.div className: 'actions',
        $.div className: 'button', onClick: @onSubmit, '登录'