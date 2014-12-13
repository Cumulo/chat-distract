
cumulo = require 'cumulo-client'

transmitter = cumulo.transmitter

store = new cumulo.Store data: {}
module.exports = store

transmitter.register 'client/sync', (data) =>
  store.sync data

transmitter.register 'client/patch', (data) =>
  store.patch data

