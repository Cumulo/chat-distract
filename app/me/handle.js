// Generated by CoffeeScript 1.3.3
var get, mode, saying;

get = function(id) {
  return document.getElementById(id);
};

mode = 'post';

saying = false;

window.onload = function() {
  var button, click_function, name, say, say_function, socket, toggle, write_topic, _ref, _ref1;
  socket = io.connect('http://localhost:8000/chat');
  socket.on('need-refresh', function() {
    return location.reload();
  });
  socket.on('ready', function() {
    return console.log('ready');
  });
  button = get('button');
  write_topic = get('write_topic');
  say = get('say');
  toggle = get('toggle');
  window.focus();
  click_function = function() {
    var topic_content;
    if (mode === 'post') {
      write_topic.style.display = 'block';
      button.innerText = 'Send';
      button.style.width = '42px';
      mode = 'topic';
      return write_topic.focus();
    } else if (mode === 'topic') {
      topic_content = write_topic.value;
      write_topic.value = '';
      socket.emit('add-topic', topic_content);
      button.innerText = '+';
      write_topic.style.display = 'none';
      button.style.width = '18px';
      return mode = 'post';
    }
  };
  button.onclick = click_function;
  say_function = function() {
    if (mode === 'topic') {
      click_function();
      return false;
    } else if (mode === 'post') {
      if (saying) {
        say.style.display = 'none';
        saying = false;
        toggle.innerText = 'oO';
      } else {
        say.style.display = 'block';
        say.focus();
        saying = true;
        toggle.innerText = 'Oo';
        socket.emit('close-post', say.value);
        say.value = '';
      }
      return false;
    }
  };
  document.onkeydown = function(e) {
    console.log(e.keyCode);
    if (e.keyCode === 13) {
      return say_function();
    }
  };
  toggle.onclick = function() {
    return say_function();
  };
  if (localStorage.name != null) {
    if ((1 < (_ref = localStorage.name.length) && _ref < 20)) {
      name = localStorage.name;
    }
  }
  while (name == null) {
    if (name == null) {
      name = prompt('choose a name:');
    }
    if (!((1 < (_ref1 = name.length) && _ref1 < 20))) {
      name = void 0;
    }
  }
  socket.emit('set-name', name);
  return localStorage.name = name;
};