
cumulo = require 'cumulo'
shortid = require 'shortid'

router = cumulo.router
profilesStore = require './profiles'

store = new cumulo.Store data: {}
module.exports = store

router.register 'account/signup', (state, data) ->
  switch
    when data.name.length is 0
      cumulo.push state, 'tip/add',
        type: 'error', msg: 'name is empty'
    when store.data[data.name]?
      cumulo.push state, 'tip/add',
        type: 'error', msg: 'name is taken'
    else
      store.data[data.name] = data.password
      user =
        id: shortid.generate()
        name: data.name
        avatar: ''
        thread: 'defailt'
        online: yes
      state.userId = user.id
      router.dispatch state, name: 'profile/add', data: user

router.register 'account/login', (state, data) ->
  switch
    when not store.data[data.name]?
      cumulo.push state, 'tip/add',
        type: 'error', msg: 'no such user'
    when store.data[data.name] isnt data.password
      cumulo.push state, 'tip/add',
        type: 'error', msg: 'wrong password'
    else
      user = lodash.find profilesStore.get(), name: data.name
      state.user = users.id
      change = online: yes
      router.dispatch state, name: 'profile/update', data: change

router.register 'account/logout', (state, data) ->
  state.userId = null
  change = online: no
  router.dispatch state, name: 'profile/update', data: change

router.register 'account/change', (state, data) ->
  switch
    when not store.data[data.name]?
      cumulo.push state, 'tip/add',
        type: 'error', msg: 'no such user'
    when store.data[name] isnt data.password
      cumulo.push state, 'tip/add',
        type: 'error', msg: 'wrong password'
    else
      store.data[data.name] = data.newPassword
      cumulo.push state, 'tip/add',
        type: 'ok', msg: 'done'