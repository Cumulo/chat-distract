
cumulo = require 'cumulo'
lodash = require 'lodash'

profilesStore = require '../store/profiles'
previewsStore = require '../store/previews'

states = require '../states'
preview = require '../view/preview'

worldScene = require './world'

module.exports = new cumulo.Scene

  data: {}
  duration: 400

  broadcast: ->
    states.each (state) =>
      preview.patch state, typing: @data, world: worldScene.get()

  listen: ->
    profilesStore.register =>
      @changed = yes
    previewsStore.register =>
      @changed = yes
    states.register =>
      preview.patch state, typing: @data, world: worldScene.get()

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
