
db =
  messages: []

exports.emit = ->
  console.log 'rewrite this in Cumulo'

exports.action = (action, data) ->
  console.log 'preview action', data
  switch action
    when 'create-message' then @createMessage data
    when 'update-message' then @updateMessage data
    when 'finish-message' then @finishMessage data

exports.createMessage = (data) ->
exports.updateMessage = (data) ->
exports.finishMessage = (data) ->
