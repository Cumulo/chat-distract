
handler = (req, res) ->
  res.end 'chat-server'
app = (require 'http').createServer handler
io = (require 'socket.io').listen app, {origins: '*:*'}
app.listen 8000

time = ->
  now = new Date()
  h = now.getHours()
  m = now.getMinutes()
  "#{h}:#{m}"

topic_store = []

chat = io.of('chat').on 'connection', (socket) ->

  my =
    name: undefined
    thread : undefined
    topic: 'default'

  socket.on 'set-name', (name) ->
    name = name.trim()
    my.name = (
      if name.length < 1 then '?'
      else if name.length > 20 then name[0..20])

  socket.on 'add-topic', (content) ->
    content = String  content
    chat.emit 'add-topic', 8

  socket.on 'sync-post', (data) ->