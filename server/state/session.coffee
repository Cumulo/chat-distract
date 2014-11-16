
{EventEmitter} = require 'events'

handler = require '../handler'
cumulo = require '../cumulo/looper'
auth = require '../util/auth'

module.exports = session = new EventEmitter

db = users: []

dbpath = '../../data/session.json'
try
  raw = require(dbpath)
  if raw then db = raw
process.on 'exit', ->
  dbpath = require('path').join __dirname, dbpath
  require('fs').writeFileSync dbpath, JSON.stringify(db)

handler.on 'session', (data) ->
  switch data.action
    when 'login' then login data
    when 'create-user' then createUser data
    else console.warn 'uncaught session action', data

cumulo.on 'patch', (data) ->
  console.log 'patch', data

login = (profile) ->
  result = auth.login profile.name, profile.password
  if result.error is null
    db.users.push profile
    session.emit 'login'

createUser = (profile) ->
  result = auth.signup profile.name, profile.password
  console.log result

removeUser = (id) ->
