
cumulo = require 'cumulo'
path = require 'path'

messages = require './store/messages'
profiles = require './store/profiles'
accounts = require './store/accounts'

cumulo.database.init
  duration: 100000

  dbPath: path.join __dirname, '../data/database.json'

  initialData:
    messages: []
    profiles: []
    accounts: {}

  gatherData: ->
    messages: messages.get()
    profiles: profiles.get()
    accounts: accounts.get()

  onLoad: (piece) ->
    messages.replace piece.messages
    profiles.replace piece.profiles
    accounts.replace piece.accounts