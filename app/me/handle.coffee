
get = (id) -> document.getElementById id
mode = 'post'
saying = no

window.onload = ->
  socket = io.connect 'http://localhost:8000/chat'

  socket.on 'need-refresh', ->
    location.reload()

  socket.on 'ready', ->
    console.log 'ready'

  button = get 'button'
  write_topic = get 'write_topic'
  say = get 'say'
  toggle = get 'toggle'

  window.focus()
  click_function = ->
    if mode is 'post'
      write_topic.style.display = 'block'
      button.innerText = 'Send'
      button.style.width = '42px'
      mode = 'topic'
      write_topic.focus()
    else if mode is 'topic'
      topic_content = write_topic.value
      write_topic.value = ''
      socket.emit 'add-topic', topic_content
      button.innerText = '+'
      write_topic.style.display = 'none'
      button.style.width = '18px'
      mode = 'post'

  button.onclick = click_function

  say_function = ->
    if mode is 'topic'
      click_function()
      false
    else if mode is 'post'
      if saying
        say.style.display = 'none'
        saying = no
        toggle.innerText = 'oO'
      else
        say.style.display = 'block'
        say.focus()
        saying = yes
        toggle.innerText = 'Oo'
        socket.emit 'close-post', say.value
        say.value = ''
      false

  document.onkeydown = (e) ->
    console.log e.keyCode
    if e.keyCode is 13
      say_function()
  toggle.onclick = ->
    say_function()

  if localStorage.name?
    if 1 < localStorage.name.length < 20
      name = localStorage.name
  until name?
    name = prompt('choose a name:') unless name?
    name = undefined unless 1 < name.length < 20
  socket.emit 'set-name', name
  localStorage.name = name