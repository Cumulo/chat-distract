
cumulo = require 'cumulo'
ws = require 'ws'
shortid = require 'shortid'

router = cumulo.router
database = cumulo.database
Server = ws.Server

states = require './states'
client = require './view/client'
preview = require './view/preview'

# bring up database
require('./database')

# for debugging
router.display = (state, action) ->
  console.log state.userId, action

wss = new Server port: 3000
wss.on 'connection', (ws) ->

  state =
    # states will dispatch based on userId?
    userId: null
    id: shortid.generate()
    cache: {}
    ws: ws
    userId: null
    messagePage: 1
    threadPage: 1
    pageStep: 5

  ws.on 'message', (raw) ->
    data = JSON.parse raw
    router.dispatch state, data

  states.register state
  console.info 'state register', state.id
  ws.on 'close', ->
    states.unregister state
    state = null
    console.info 'state unregister', state.id

  # seed browsers
  client.sync state
  preview.sync state
