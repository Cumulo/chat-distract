
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

topic_store = {}
push_topic = (item) -> topic_store[item.id] = item

chat = io.of('/chat').on 'connection', (socket) ->
  socket.on 'fresh-list', ->
    socket.emit 'fresh-list', topic_store

  my =
    name: '?'
    thread: undefined
    topic: undefined

  socket.on 'set-name', (name) ->
    name = String name
    name = name.trim()
    my.name = (
      if name.length < 1 then '?'
      else if name.length > 20 then name[0..20]
      else name)
    console.log 'now name is', name

  socket.on 'add-topic', (content) ->
    content = String  content
    if content.length < 5 then return ''
    else if content.length > 30 then content[0..30]
    store =
      id: mark()
      time: time()
      reply: 0
      author: my.name
      content: content
    push_topic store
    chat.emit 'add-topic', store

  socket.on 'topic', (topic) ->
    topic = String topic
    if topic isnt my.topic
      if my.topic? then socket.leave my.topic
      socket.join topic
      my.topic = topic
      socket.emit 'topic', topic

  socket.on 'away', ->
    if my.topic?
      socket.leave my.topic
      my.topic = undefined

  socket.on 'delete-topic', (topic) ->
    topic = String topic
    if topic_store[topic] then delete topic_store[topic]

  socket.on 'close', (text) ->
    text = String text
    store =
      topic: my.topic
      id: mark()
      time: time()
      author: my.name
      content: text
    chat.emit 'close', store
    my.thread = undefined

  socket.on 'open', ->
    my.thread = mark()

  socket.on 'sync', (data) ->
    store =
      author: my.name
      content: data
      thread: my.thread
    socket.broadcast.to(my.topic).emit 'sync', store

fs.watch 'app/me/handle.js', ->
  chat.emit 'need-refresh'