
{EventEmitter} = require 'events'
handler = require '../handler'

module.exports = store = new EventEmitter

db =
  messages: []
  users: []

dbpath = '../../data/store.json'
try
  raw = require(dbpath)
  if raw then db = raw
process.on 'exit', ->
  dbpath = require('path').join __dirname, dbpath
  require('fs').writeFileSync dbpath, JSON.stringify(db)

handler.on 'store', (data) ->
  switch data.action
    when 'create-message' then createMessage data
    when 'create-user' then createUser data
    else console.warn 'uncaught store action', data

createMessage = (data) ->
  store.emit 'change'

createUser = (data) ->
  store.emit 'change'