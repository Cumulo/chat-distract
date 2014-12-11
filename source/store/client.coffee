
cumulo = require 'cumulo-client'

transmitter = cumulo.transmitter

store = new cumulo.Store data: {}
module.exports = store

transmitter.register 'client/sync', store.sync
transmitter.register 'client/patch', store.patch
