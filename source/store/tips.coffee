
cumulo = require 'cumulo-client'

transmitter = cumulo.transmitter

store = new cumulo.Store data: []

module.exports = store

transmitter.register 'tip/add', (data) ->
  store.data.unshift data
  store.dispatch()

transmitter.register 'tip/remove', (id) ->
  store.data = store.data.filter (tip) ->
    tip.id isnt id
  store.dispatch()
