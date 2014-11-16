
React = require 'react'

ws = new WebSocket 'ws://localhost:3000'

ws.json = (data) ->
  @send JSON.stringify data

ws.onopen = ->
  ws.json type: 'store', action: 'name'
  ws.json type: 'preview', action: 'name'