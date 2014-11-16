
db =
  keys: {}

dbpath = '../../data/auth.json'
try
  raw = require(dbpath)
  if raw then db = raw
catch error
  console.error error
process.on 'exit', ->
  dbpath = require('path').join __dirname, dbpath
  require('fs').writeFileSync dbpath, JSON.stringify(db)

exports.login = (name, password) ->
  if db.keys[name] is password
    error: null
  else
    error: 'password not match'

exports.signup = (name, password) ->
  if db.keys[name]?
    error: 'name is taken'
  else
    db.keys[name] = password
    error: null

exports.change = (name, password, newPassword) ->
  if db.keys[name]?
    if db.keys[name] is password
      db.keys[name] = newPassword
      error: null
    else
      error: 'password not match'
  else
    error: 'no such user'