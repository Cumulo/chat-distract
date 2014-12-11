
cumulo = require 'cumulo'
path = require 'path'

messages = require './store/messages'
profiles = require './store/profiles'
accounts = require './store/accounts'
previews = require './store/previews'

cumulo.database.init
  dbPath: path.join __dirname, '../data/database.json'
  initialDatabase:
    messages: []
    profiles: []
    accounts: {}
  shrinkDatabase: ->
    messages: messages.clone()
    profiles: profiles.clone()
    accounts: accounts.clone()
  onLoad: (piece) ->
    messages.replace piece.messages
    profiles.replace piece.profiles
    accounts.replace piece.accounts