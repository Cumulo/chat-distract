
cumulo = require 'cumulo'
lodash = require 'lodash'

router = cumulo.router

store = new cumulo.Store data: []
module.exports = store

router.register 'profile/add', (state, data) ->
  store.data.push data
  store.dispatch()

router.register 'profile/update', (state, data) ->
  record = lodash.find store.data, id: state.userId
  lodash.assign record, data
  store.dispatch()

router.register 'profile/changeThread', (state, data) ->
  state.messagePage = 1
  record = lodash.find store.data, id: state.userId
  record.thread = data
  store.dispatch()