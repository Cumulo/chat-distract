
cumulo = require 'cumulo'

router = cumulo.router

store = new cumulo.Store data: []
module.exports = store

router.register 'message/create', (state, data) ->
  # todo
  store.dispatch()

router.register 'message/setThread', (state, data) ->
  # todo
  store.dispatch()
