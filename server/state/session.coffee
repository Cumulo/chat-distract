
{EventEmitter} = require 'events'

handler = require '../handler'
cumulo = require '../cumulo/looper'

db =
  users: []

handler.on 'session', (data) ->
  switch data.action
    when 'create-user' then createUser data
    else console.warn 'uncaught session action', data

cumulo.on 'patch', (data) ->
  console.log 'patch', data

createUser = (profile) ->

removeUser = (id) ->
