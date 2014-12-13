
cumulo = require 'cumulo'
lodash = require 'lodash'

states = require '../states'

module.exports = new cumulo.View

  cacheName: 'preview'

  syncSolution: (state, data) ->
    cumulo.push state, 'preview/sync', data

  patchSolution: (state, data) ->
    cumulo.push state, 'preview/patch', data

  renderGuest: ->
    []

  render: (state, scene) ->
    typing = scene.typing
    world = scene.world

    user = lodash.find world.users, id: state.userId
    typing[user.thread]
