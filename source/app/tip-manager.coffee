
React = require 'react/addons'
cumulo = require 'cumulo-client'

tipsStore = require '../store/tips'

ModuleTip = require '../module/tip'

$ = React.DOM
transmitter = cumulo.transmitter

module.exports = React.createFactory React.createClass
  displayName: 'tip-manager'

  getInitialState: ->
    data: tipsStore.get()

  componentDidMount: ->
    tipsStore.register @onChange

  componentWillUnmount: ->
    tipsStore.unregister @onChange

  onChange: ->
    @setState data: tipsStore.get()

  onTipClick: (id) ->
    transmitter.dispatch name: 'tip/remove', data: id

  render: ->

    $.div className: 'tip-manager paragraph',
      @state.data.map (tipData) =>
        ModuleTip key: tipData.id, data: tipData, onClick: @onTipClick
