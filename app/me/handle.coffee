
window.onload = ->
  socket = io.connect 'http://localhost:8000/chat'

  socket.on 'need-refresh', ->
    location.reload()

  socket.on 'ready', ->
    console.log 'ready'

  window.focus()
  named = no
  saying = no
  mode = ''

  get = (id) -> document.getElementById id
  right  = get 'right'
  topics = get 'topics'
  create = get 'create'
  say    = get 'say'
  name   = get 'name'
  clear  = get 'clear'

  change_mode = (item) ->
    if item isnt mode
      mode = item
      say.style.color = (
        if item is 'say' then 'hsl(0,0%,50%)'
        else 'hsl(0,0%,80%)' )

  topic_list = []
  topic_store = {}
  
  say_action = ->
      change_mode 'say'

  topics.onclick = ->
    if mode isnt 'topics'
      change_mode 'topics'
      for item in topic_list
        log item

  create.onclick = ->
    if mode isnt 'create'
      change_mode 'create'
      right.innerHTML = 'create mode'

  say.onclick = ->
    if mode isnt 'say' then say_action()

  do name.onclick = ->
    if mode isnt 'name'
      change_mode 'name'
      right.innerHTML = '<div id="name_msg">Input A Name: (1 < Length < 20)</div>
        <textarea id="name_box"></textarea>
        <div id="name_send">Waiting</div>'
      name_msg = get 'name_msg'
      name_box = get 'name_box'
      name_send = get 'name_send'
      name_box.focus()
      name_box.oninput = ->
        if name_box.value.length < 2
          name_msg.innerText = 'Too Short'
          name_send.innerText = 'Waiting'
          name_send.onclick = ->
        else if name_box.value.length > 20
          name_msg.innerText = 'Too Long now..'
          name_send.innerText = 'Waiting'
          name_send.onclick = ->
        else
          name_msg.innerText = 'This name should be OK'
          name_send.innerText = 'Send'
          name_send.onclick = ->
            socket.emit 'set-name', name_box.value
            name_msg.innerText = 'Already Sent'
            name_send.innerText = 'Sent'
          name_box.onkeydown = (e) ->
            if e.keyCode is 13
              name_send.onclick()
              false
    else (get 'name_box').focus()

  clear.onclick = ->
    topic_list = []
    topic_store = {}
    socket.emit 'reload'