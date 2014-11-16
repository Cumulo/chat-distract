
{EventEmitter} = require 'events'

module.exports = cumulo = new EventEmitter

store = require '../props/store'
preview = require '../props/preview'
session = require '../state/session'

cumulo.emit 'nochange', data: 'nothing'