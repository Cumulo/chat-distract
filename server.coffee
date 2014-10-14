
User = require 'src/user'
Cumulo = require 'src/cumulo'

cumulo = new Cumulo
cumulo.createPage 'messages'

ws.onConnect (client) ->
  user = new User
    cumulo: cumulo
  client.registerUser 'anonymous'
  cumulo.registerUserPage user,
    name: 'message'
    step: 10
  user.render()

  cumulo.registerUser user

  client.on 'close', ->
    cumulo.unregister user
    user = null