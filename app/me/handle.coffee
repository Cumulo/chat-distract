
window.onload = ->
  socket = io.connect 'http://localhost:8000/chat'

  socket.on 'need-refresh', ->
    location.reload()

  socket.on 'ready', ->
    console.log 'ready'

  window.focus()
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
      if item isnt 'say' then socket.emit 'away'

  topic_store = {}
  post_store = {}
  
  say_action = ->
      change_mode 'say'

  topics.onclick = ->
    if mode isnt 'topics'
      change_mode 'topics'
      render_topics()

  create.onclick = ->
    if mode isnt 'create'
      change_mode 'create'
      right.innerHTML = '<div id="create_msg">Start a New Topic Here: (5 < Length < 40)</div>
        <textarea id="create_box"></textarea>
        <div id="create_send">Waiting</div>'
      create_msg = get 'create_msg'
      create_box = get 'create_box'
      create_send = get 'create_send'
      create_box.focus()
      create_box.oninput = ->
        if create_box.value.length < 6
          create_msg.innerText = 'Add More Words to be a Topic:'
          create_send.innerText = 'Waiting'
          create_send.onclick = ->
          create_send.onkeydown = ->
        else if create_box.value.length > 40
          create_msg.innerText = 'The Title Contains too many Words..'
          create_send.innerText = 'Waiting'
          create_send.onclick = ->
          create_send.onkeydown = ->
        else
          create_msg.innerText = 'Right Length now'
          create_send.innerText = 'Send'
          create_send.onclick  = ->
            socket.emit 'add-topic', create_box.value
            create_msg.innerText = 'OK, You\'ve Sent the Topic Successfully'
            create_send.innerText = 'Sent'
            create_send.onclick  = ->
            create_box.blur()
          create_box.onkeydown = (e) ->
            if e.keyCode is 13
              create_send.onclick()
              false
    else (get 'create_box').focus()

  say.onclick = ->
    if mode is 'say' then say_action()

  name.onclick = ->
    if mode isnt 'name'
      change_mode 'name'
      right.innerHTML = '<div id="name_msg">Set Your Name: (1 < Length < 20)</div>
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
          name_box.onkeydown = ->
        else if name_box.value.length > 20
          name_msg.innerText = 'Too Long now..'
          name_send.innerText = 'Waiting'
          name_send.onclick = ->
          name_box.onkeydown = ->
        else
          name_msg.innerText = 'This name should be OK'
          name_send.innerText = 'Send'
          name_send.onclick = ->
            socket.emit 'set-name', name_box.value
            localStorage.name = name_box.value
            name_msg.innerText = 'Already Sent'
            name_send.innerText = 'Sent'
            name_send.onclick = ->
            name_box.blur()
          name_box.onkeydown = (e) ->
            if e.keyCode is 13
              name_send.onclick()
              false
    else (get 'name_box').focus()

  if localStorage.name?
    socket.emit 'set-name', localStorage.name
    socket.emit 'fresh-list'
  else name.onclick()

  clear.onclick = ->
    topic_store = {}
    socket.emit 'fresh-list'

  render_topics = ->
    console.log 'do render_topics'
    html = ''
    for key, value of topic_store
      html += "<div class='post' id='#{value.id}'>
        <div class='date'>#{value.time}</div>
        <div class='reply'>+#{value.reply}</div>
        <div class='name'>#{value.author}</div>
        <div class='text'>#{value.content}</div>
        </div>"
    right.innerHTML = html
    for key, value of topic_store
      ((key) ->
        (get key).onclick = ->
          socket.emit 'topic', key) key

  socket.on 'fresh-list', (data) ->
    topic_store = data
    render_topics()

  socket.on 'add-topic', (data) ->
    topic_store[data.id] = data
    if mode is 'topics'
      add_div = document.createElement 'div'
      add_div.setAttribute 'class', 'post'
      add_div.innerHTML = "
          <div class='date'>#{data.time}</div>
          <div class='reply'>+#{value.reply}</div>
          <div class='name'>#{data.author}</div>
          <div class='text'>#{data.content}</div>"
      right.appendChild add_div
      add_div.onclick = ->
        ((key) -> socket.emit 'topic', key) data.id

  socket.on 'topic', (topic) ->
    if mode isnt 'say'
      change_mode 'say'
      if topic_store[topic]? then topic_view = topic_store[topic]
      else topic_view =
        id: topic
        reply: -1
        name: '?'
        text: '??'
      right.innerHTML = "
        <div class='post head'>
          <div class='date'>#{topic_view.time}</div>
          <div class='name'>#{topic_view.author}</div>
          <div id='block'>Click to Send Remove Signal</div>
          <div class='text'>#{topic_view.content}</div>
        </div>"
      if post_store[topic]?
        for key, value of post_store[topic]
          right.innerHTML += "
            <div class='post'>
              <div class='date'>#{value.time}</div>
              <div class='name'>#{value.author}</div>
              <div class='text'>#{value.content}</div>
            </div>"