
module.exports = class
  constructor: (options) ->
    @pages = []
    @cumulo = options.cumulo

  registerPage: (props) ->
    info =
      name: props.name
      step: props.step or 10
      begin: props.begin or null
      ended: no
    @pages.push info
    info

  initialState: ->

  setPageState: (page) ->

  pushClient: (operations) ->
    if operations.length is 0
      return

  listenClient: (operation) ->

  pageView: (data) ->
    @pages.push
      id:
    @cumulo.registerChange
      id: data.id
      page: data.page
      userId: @id
      from: null

  pageMore: (data) ->

  pageDrop: (data) ->
