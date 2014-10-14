
time = require './helper/cumulo'

module.exports = class
  constructor: ->
    @users = []
    @data = []
    @updates = []
    @changes = []
    @stateChanged = no

    @registerPage 'user'
    @step = 10
    @eventLoop()

  registerPage: (name) ->
    @data[name] = []

  registerUser: (user) ->
    @users.push user

  create: (page, data) ->
    data.createTime = data.updateTime = time.now()
    @data[page].unshift data
    @updates.push {op: 'create', page, data}

  update: (page, data) ->
    for item in @data[page]
      if item.id is data.id
        for key, value of data
          item[key] = value
          data.updateTime = time.now()
          @updates.push {op: 'update', page, data}
        break

  delete: (page, id) ->
    for item, index in @data[page]
      if item.id is data.id
        x = @data[page].splice index, 1
        @updates.push {op: 'delete', page, data}
        break

  registerChange: (change) ->
    @changes.push change

  handleUpdate: ->
    for user in @users
      updates = []
      for page in user.pages
        for update in @updates
          unless page.ended
            if page.name is update.page
              updates.push update
      user.pushClient updates
    @updates = []

  handleChanges: ->
    for user in @users
      changes = []
      for change in @changes
        if change.userId is user.id
        switch change.type
          when 'view'
            data = @data[change.page][0...10]
            name: change.page
            start: null

          when 'more'
            change.page
          when 'drop'
            change.page
      user.pushClient changes
    @changes = []

  eventLoop: ->
    setTimeout eventLoop.bind(@), 1000
    @handleUpdate()
    @handleChanges()