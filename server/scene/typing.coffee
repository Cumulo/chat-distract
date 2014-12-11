
cumulo = require 'cumulo'

states = require '../states'
preview = require '../view/preview'

module.exports = new cumulo.Scene

  broadcast: ->
    states.each (state) ->
      preview.patch state

  render: ->
    # todo
