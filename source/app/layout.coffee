
React = require 'react/addons'
cumulo = require 'cumulo-client'

# components
ThreadList = require './thread-list'
MessageList = require './message-list'
ActionBar = require './action-bar'
TipManager = require './tip-manager'
AccountAction = require './account-action'
MessageBox = require './message-box'

$ = React.DOM
cx = React.addons.classSet

module.exports = React.createFactory React.createClass
  displayName: 'app-layout'

  propTypes:
    store: React.PropTypes.object.isRequired

  onDefaultThreadClick: ->
    cumulo.send 'profile/changeThread', 'default'

  renderAccountAction: ->
    $.div className: 'guest-page',
      AccountAction()

  renderMessage: ->
    $.div className: 'main-page',
      $.div className: 'thread-wrap',
        $.div
          className: cx
            'default-thread': yes
            'is-inside': @props.store.user?.thread is 'default'
          onClick: @onDefaultThreadClick
          '欢迎来到聊天室, 这是一个测试版的聊天室'
        ThreadList data: @props.store.threads, user: @props.store.user
      $.div className: 'message-wrap',
        MessageList data: @props.store.messages
        MessageBox()
      ActionBar user: @props.store.user

  render: ->
    $.div className: 'app-layout',
      if @props.store?.user?
      then @renderMessage()
      else @renderAccountAction()
      TipManager()