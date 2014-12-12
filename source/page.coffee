
React = require 'react/addons'

AppLayout = require './app/layout'
client = require './store/client'

render = ->
  component = AppLayout
    store: client.get()
  React.render component, document.body

client.register render
# initialize page
render()