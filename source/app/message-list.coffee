
React = require 'react/addons'
lodash = require 'lodash'
cumulo = require 'cumulo-client'

preview = require '../store/preview'

AppMessage = require './message'
AppTyping = require './typing'
orders = require '../util/orders'

$ = React.DOM

module.exports = React.createFactory React.createClass
  displayName: 'message-list'

  propTypes:
    data: React.PropTypes.array

  getInitialState: ->
    preview: preview.get().typing

  componentWillUpdate: ->
    @_atBottom = @isScrollAtBottom()
    @_atTop = @isScrollAtTop()
    @_scrollHeight = @refs.root.getDOMNode().scrollHeight

  componentDidUpdate: ->
    if @_atBottom then @scrollToBottom()
    if @_atTop then @scrollTopBack()
    @_atBottom = null
    @_atTop = null

  componentDidMount: ->
    @scrollToBottom()
    preview.register @onPreviewUpdate
    @_detectLoading = lodash.debounce @detectLoading, 600

  componentWillUnmount: ->
    preview.unregister @onPreviewUpdate

  # custom methed

  scrollToBottom: ->
    node = @refs.root.getDOMNode()
    node.scrollTop = node.scrollHeight

  scrollTopBack: ->
    node = @refs.root.getDOMNode()
    h = node.scrollHeight
    t = node.scrollTop
    diff = h - @_scrollHeight
    node.scrollTop = t + diff

  isScrollAtBottom: ->
    node = @refs.root.getDOMNode()
    h = node.clientHeight
    a = node.scrollHeight
    b = node.scrollTop
    (b + h + 20) > a

  isScrollAtTop: ->
    node = @refs.root.getDOMNode()
    node.scrollTop < 20

  detectLoading: (event) ->
    report.morePage()

  # event listener

  onPreviewUpdate: ->
    if @isMounted()
      @setState preview: preview.get().typing

  onWheel: (event) ->
    @_detectLoading event

  # render methods

  renderMessages: ->
    @props.data.concat()
    .sort orders.time
    .map (message) =>
      AppMessage key: message.id, data: message

  renderPreview: ->
    @state.preview?.concat()
    .map (obj) =>
      AppTyping key: obj.sid, data: obj

  render: ->

    $.div ref: 'root', className: 'message-list', onWheel: @onWheel,
      @renderMessages()
      @renderPreview()