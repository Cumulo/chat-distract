
cumulo = require 'cumulo'

router = cumulo.router

store = new cumulo.Store data: []
module.exports = store

router.register 'preview/text', (state, data) ->
  # todo
  store.dispatch()

router.register 'preview/remove', (state, data) ->
  # todo
  store.dispatch()