
cumulo = require 'cumulo-client'

transmitter = cumulo.transmitter

store = new cumulo.Store data: []
module.exports = store

transmitter.register 'preview/sync', store.sync
transmitter.register 'preview/patch', store.patch
