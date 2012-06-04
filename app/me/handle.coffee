
get = (id) -> document.getElementById id
mode = 'post'

window.onload = ->
  socket = io.connect 'http://localhost:8000/chat'

  socket.on 'need-refresh', ->
    location.reload()

  socket.on 'ready', ->
    console.log 'ready'

  button = get 'button'
  button.onclick = ->
    alert 'clicked'