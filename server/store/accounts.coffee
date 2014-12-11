
cumulo = require 'cumulo'

router = cumulo.router

store = new cumulo.Store data: []
module.exports = store

router.register 'account/signup', (state, data) ->
  # todo

router.register 'account/login', (state, data) ->
  # todo

router.register 'account/logout', (state, data) ->
  # todo

router.register 'account/change', (state, data) ->
  # todo
