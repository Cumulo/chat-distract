
cumulo = require 'cumulo-client'

transmitter = cumulo.transmitter

store = new cumulo.Store data: []
module.exports = store

transmitter.register 'tip/add', store.add
