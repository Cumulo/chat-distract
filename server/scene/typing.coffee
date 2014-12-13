
cumulo = require 'cumulo'
lodash = require 'lodash'

profilesStore = require '../store/profiles'
previewsStore = require '../store/previews'

states = require '../states'
preview = require '../view/preview'

world = require './world'

module.exports = new cumulo.Scene

  data: {}
  duration: 100

  broadcast: ->
    states.each (state) =>
      preview.patch state, typing: @data, world: world.get()

  listen: ->
    profilesStore.register =>
      @changed = yes
    previewsStore.register =>
      @changed = yes
    states.register =>
      preview.patch state, typing: @data, world: world.get()

  render: ->
    profiles = profilesStore.get()
    previews = previewsStore.get()

    previews = previews
    .filter (data) ->
      data.text.trim().length > 0
    .map (data) ->
      profile = lodash.find profiles, id: data.userId
      data.user = profile
      data
    groups = lodash.groupBy previews, 'thread'

    @data = groups
