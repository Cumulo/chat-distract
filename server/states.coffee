
cumulo = require 'cumulo'
lodash = require 'lodash'

router = cumulo.router
states = new cumulo.State

module.exports = states

router.register 'state/morePage', (state, data) ->
  # todo
  states.dispatch state

router.register 'state/update', (state, data) ->
  # todo
  states.dispatch state