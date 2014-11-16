
keys = {}

exports.login = (name, password) ->
  if keys[name] is password
    error: null
  else
    error: 'password not match'

exports.signup = (name, password) ->
  if keys[name]?
    error: 'name is taken'
  else
    keys[name] = password
    error: null

exports.change = (name, password, newPassword) ->
  if keys[name]?
    if keys[name] is password
      keys[name] = newPassword
      error: null
    else
      error: 'password not match'
  else
    error: 'no such user'