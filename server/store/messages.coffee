
cumulo = require 'cumulo'
shortid = require 'shortid'

profilesStore = require './profiles'
time = require '../util/time'

router = cumulo.router

store = new cumulo.Store data: []
module.exports = store

router.register 'message/create', (state, data) ->
  user = lodash.where profilesStore.get(), id: state.userId
  msg =
    id: shortid.generate()
    time: time.now()
    userId: user.id
    text: data
    thread: user.thread
    isThread: no
  store.data.push msg
  store.dispatch()

router.register 'message/setThread', (state, data) ->
  lodash.find(store.data, id: data).isThread = yes
  store.dispatch()
