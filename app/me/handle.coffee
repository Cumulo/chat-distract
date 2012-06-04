
get = (id) -> document.getElementById id
mode = 'post'

window.onload = ->
  socket = io.connect 'http://localhost:8000/chat'

  socket.on 'need-refresh', ->
    location.reload()

  socket.on 'ready', ->
    console.log 'ready'

  button = get 'button'
  write_topic = get 'write_topic'

  click_function = ->
    if mode is 'post'
      write_topic.style.display = 'block'
      button.innerText = 'Send'
      button.style.width = '40px'
      mode = 'topic'
    else if mode is 'topic'
      topic_content = write_topic.value
      console.log topic_content
      button.innerText = '+'
      write_topic.style.display = 'none'
      button.style.width = '13px'
      mode = 'post'
  button.onclick = click_function

  until name?
    name = prompt('choose a name:')
    name = undefined unless 1 < name.length < 20
  socket.emit 'set-name', name