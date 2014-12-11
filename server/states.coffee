
cumulo = require 'cumulo'
lodash = require 'lodash'

router = cumulo.router
module.exports = cumulo.state

client = require './view/client'
preview = require './view/preview'

router.register 'state/morePage', (state, data) ->
  # todo
  client.patch state
  preview.patch state

router.register 'state/update', (state, data) ->
  # todo
  client.patch state
  preview.patch state