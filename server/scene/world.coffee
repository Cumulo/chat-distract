
cumulo = require 'cumulo'
lodash = require 'lodash'

profilesStore = require '../store/profiles'
messagesStore = require '../store/messages'

states = require '../states'
client = require '../view/client'

orders = require '../util/orders'

module.exports = new cumulo.Scene

  data: {}

  duration: 400

  broadcast: ->
    states.each (state) ->
      client.patch state, world: @get()

  listen: ->
    profilesStore.register =>
      @changed = yes
    messagesStore.register =>
      @changed = yes
    states.register =>
      client.patch state, world: @get()

  render: ->
    profiles = profilesStore.get()
    messages = messagesStore.get()
    .map (message) ->
      profile = lodash.find profiles, id: message.userId
      message.user = profile
      message
    .sort orders.time

    threads = messages.filter (message) ->
      message.isThread
    groups = lodash.groupBy messages, 'thread'

    users: profiles
    threads: threads
    messages: groups
