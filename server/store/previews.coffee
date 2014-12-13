
cumulo = require 'cumulo'
lodash = require 'lodash'
shortid = require 'shortid'

profilesStore = require './profiles'
time = require '../util/time'

router = cumulo.router

store = new cumulo.Store data: []
module.exports = store

router.register 'preview/text', (state, data) ->
  user = lodash.find profilesStore.get(), id: state.userId
  info =
    id: shortid.generate()
    sid: state.id
    thread: user.thread
    userId: state.userId
    text: data
    textTime: time.now()
  record = lodash.find store.data, sid: state.id
  if record?
  then lodash.assign record, info
  else store.data.push info
  store.dispatch()

router.register 'preview/remove', (state, data) ->
  matchStateId = (x) -> x.sid is state.id
  lodash.remove store.data, matchStateId
  store.dispatch()
