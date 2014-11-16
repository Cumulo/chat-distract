
WebSocketServer = require('ws').Server
EventEmitter = require('events').EventEmitter

module.exports = browser = new EventEmitter

store = require './props/store'
preview = require './props/preview'
session = require './state/session'

wss = new WebSocketServer port: 3000
console.log 'WebSocketServer at 3000'

wss.on 'connection', (ws) ->
  ws.on 'message', (raw) ->
    try
      data = JSON.parse raw
    catch error
      console.warn error
      data =
        error: 'parse error'

    switch data.type
      when 'store' then browser.emit 'store', data
      when 'preview' then browser.emit 'preview', data
      when 'session' then browser.emit 'session', data
      else console.warn 'uncaught message:', data