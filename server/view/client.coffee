
cumulo = require 'cumulo'

module.exports = new cumulo.View

  render: (state) ->
    unless state.userId?
      user: null
      messages: []
      threads: []

  getCache: (state) ->
    # todo

  setCache: (state, data) ->
    # todo

  syncSolution: (state, data) ->
    # todo

  patchSolution: (state, data) ->
    # todo
