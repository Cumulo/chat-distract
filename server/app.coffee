
cumulo = require 'cumulo'
ws = require 'ws'
shortid = require 'shortid'

# bring up database
require('./database')
require('./scene/typing')
require('./scene/world')

router = cumulo.router
database = cumulo.database
Server = ws.Server

states = require './states'

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
    page:
      message: 1
      thread: 1
      step: 5

  ws.on 'message', (raw) ->
    data = JSON.parse raw
    router.dispatch state, data

  states.record state
  console.info 'state record', state.id
  ws.on 'close', ->
    states.unrecord state
    console.info 'state unrecord', state.id
    state = null
