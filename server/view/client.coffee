
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

  renderUser: (state, scene) ->
    typing = scene.typing
    threads = scene.world.threads

    user = lodash.find scene.world.users, id: state.userId
    messages = scene.world.messages[user.thread] or []

    page = state.page
    threadLen = page.thread * page.step
    messageLen = page.message * page.step

    messagesInView = messages[...threadLen]
    threadsInView = threads[...messageLen]

    user: user
    threads: threadsInView
    messages: messagesInView

