
React = require 'react/addons'

AppLogin = require './login'
AppSignup = require './signup'

$ = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'account-action'

  getInitialState: ->
    tab: 'login' # signup

  onLoginClick: ->
    @setState tab: 'login'

  onSignupClick: ->
    @setState tab: 'signup'

  render: ->

    $.div className: 'account-action',
      $.div className: 'tabs line',
        $.span className: 'login tab', onClick: @onLoginClick, '登录'
        $.span className: 'signup tab', onClick: @onSignupClick, '注册'
      switch @state.tab
        when 'login' then AppLogin()
        when 'signup' then AppSignup()
        when 'change' then ChangePassword()