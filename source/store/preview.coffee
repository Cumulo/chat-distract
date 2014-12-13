
cumulo = require 'cumulo-client'

transmitter = cumulo.transmitter

store = new cumulo.Store data: []
module.exports = store

transmitter.register 'preview/sync', (data) =>
  store.sync data

transmitter.register 'preview/patch', (data) =>
  store.patch data
