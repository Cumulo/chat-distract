
React = require 'react'
cumulo = require 'cumulo-client'

session = cumulo.session
transmitter = cumulo.transmitter

ws = new WebSocket 'ws://localhost:3000'
cumulo.ws = ws

ws.onopen = ->
  remember = session.get()
  if remember?
    data =
      name: remember.name
      password: remember.password
    cumulo.send 'account/login', data

ws.onmessage = (messageObject) ->
  raw = messageObject.raw
  action = JSON.parse raw
  transmitter.dispatch action
