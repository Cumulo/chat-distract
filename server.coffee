
server = require 'ws-json-server'

session = require './src/session'
store = require './src/store'

server.onconnect (ws) ->
  user = undefined
  ws.on 'ready', (data) ->
    if data.id?
      user = session.findById data.id
    unless user?
      user =
        id: shortid.generate()
        name: 'default'
        ws: ws
      session.add user
    store.addUser user

  ws.on 'session', (data) ->

  ws.on 'store', (data) ->