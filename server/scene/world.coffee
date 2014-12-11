
cumulo = require 'cumulo'

states = require '../states'
client = require '../view/client'

module.exports = new cumulo.Scene

  broadcast: ->
    states.each (state) ->
      client.patch state

  render: ->
    # todo
