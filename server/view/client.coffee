
cumulo = require 'cumulo'
lodash = require 'lodash'

module.exports = new cumulo.View

  cacheName: 'client'

  syncSolution: (state, data) ->
    cumulo.push state, 'client/sync', data

  patchSolution: (state, data) ->
    cumulo.push state, 'client/patch', data

  renderGuest: ->
    user: null
    messages: []
    threads: []

  render: (state, scene) ->
    world = scene.world
    typing = scene.typing

    page = state.page
    threadLen = page.thread * page.step
    messageLen = page.message * page.step

    user = lodash.find world.users, id: state.userId
    messages = world.messages[user.thread][...threadLen]
    threads = world.threads[...messageLen]

    {user, threads, messages}
