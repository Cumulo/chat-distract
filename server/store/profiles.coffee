
cumulo = require 'cumulo'

router = cumulo.router

store = new cumulo.Store data: []
module.exports = store

router.register 'profile/update', (state, data) ->
  # todo
  store.dispatch()

router.register 'profile/changeThread', (state, data) ->
  # todo
  store.dispatch()