
React = require 'react'
cumulo = require 'cumulo-client'

session = cumulo.session
transmitter = cumulo.transmitter

# activate page rendering
require './page'

ws = new WebSocket 'ws://localhost:3000'
cumulo.ws = ws

ws.onopen = ->
  remember = session.get()
  if remember?.name?
    data =
      name: remember.name
      password: remember.password
    cumulo.send 'account/login', data

ws.onmessage = (messageObject) ->
  raw = messageObject.data
  action = JSON.parse raw
  transmitter.dispatch action
