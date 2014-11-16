
React = require 'react'

ws = new WebSocket 'ws://localhost:3000'

ws.json = (data) ->
  @send JSON.stringify data

ws.action = (type, action, data) ->
  data.type = type
  data.action = action
  ws.json data

ws.onopen = ->

  ws.action 'session', 'create-user',
    name: 'chen'
    password: '123456'