
fs = require 'fs'

handler = (req, res) ->
  res.end 'chat-server'
app = (require 'http').createServer handler
io = (require 'socket.io').listen app, origins: '*:*'
io.set 'log level', 1
app.listen 8000

time = ->
  now = new Date()
  h = now.getHours()
  m = now.getMinutes()
  "#{h}:#{m}"

mark = -> new Date().getTime().toString()[4..]

topic_store = []
push_topic = (item) -> topic_store.push item

chat = io.of('/chat').on 'connection', (socket) ->
  socket.emit 'ready'

  my =
    name: undefined
    thread : undefined
    topic: 'default'

  socket.on 'set-name', (name) ->
    name = name.trim()
    my.name = (
      if name.length < 1 then '?'
      else if name.length > 20 then name[0..20])
    console.log 'now name is', name

  socket.on 'add-topic', (content) ->
    content = String  content
    if content.length < 5 then return ''
    else if content.length > 30 then content[0..30]
    store =
      id: mark()
      content: content
      delete_vote: 0
      last: mark()
    push_topic store
    console.log topic_store
    chat.emit 'add-topic', store

  socket.on 'sync-post', (data) ->

fs.watch 'app/me/handle.js', ->
  chat.emit 'need-refresh'