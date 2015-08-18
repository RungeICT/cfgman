require("./util/promise-poly")()


Templates = require "./templates"
React = require "react"
Router = require "react-router"
{Route, DefaultRoute, RouteHandler} = Router

App = React.createClass {
  render: () ->
    <div>
      <RouteHandler />
    </div>
}

routes = <Route name="app" path="/" handler={App}>
  <DefaultRoute handler={Templates}/>
</Route>

Router.run routes, Router.HistoryLocation, (Handler) ->
  React.render <Handler/>, document.getElementById('react-component')
