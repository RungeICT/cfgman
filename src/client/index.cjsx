require("./util/promise-poly")()

Templates = require "./templates"
Devices = require "./devices"
logic = require "./logic"

React = require "react"
Router = require "react-router"
reduxRouteComponent = require 'redux-react-router';
{Route, DefaultRoute, RouteHandler, State} = Router
{ Provider  } = require "react-redux"
{NavItemLink} = require "react-router-bootstrap"
{ Navbar, Nav} = require "react-bootstrap"
{ DevTools, DebugPanel, LogMonitor } = require 'redux-devtools/lib/react';
logic = require "./logic"

App = React.createClass {
  mixins: [State]
  checkStore: () ->
    logic.templates.select(@getParams().templateId)
    logic.devices.select(@getParams().deviceId)

  componentWillMount: () ->
    @checkStore()
  componentWillReceiveProps: (nextProps) ->
    @checkStore()

  render: () ->
    <div>
      <div className="container-fluid">
        <Navbar brand='CfgMan'>
          <Nav>
            <NavItemLink to='/'>{"Templates"}</NavItemLink>
            <NavItemLink to='/devices'>{"Devices"}</NavItemLink>
          </Nav>
        </Navbar>
      </div>
      <RouteHandler />

    </div>
}
###
      <DebugPanel top right bottom>
        <DevTools store={logic.store} monitor={LogMonitor} />
      </DebugPanel>
###


Bridge = React.createClass {

  componentWillMount: () ->

    logic.devices.load()
    logic.templates.load()

  initFunc: ->
    return <App />

  render: () ->
    <Provider store={logic.store}>
      {@initFunc}
    </Provider>
}

routes = <Route name="app" path="/" handler={Bridge}>
  <DefaultRoute handler={Templates}/>
  <Route path="/templates" handler={Templates} />
  <Route path="/templates/:templateId" handler={Templates} />
  <Route path="/devices" handler={Devices} />
  <Route path="/devices/:deviceId" handler={Devices} />
</Route>



Router.run routes, Router.HistoryLocation, (Handler) ->
  React.render <Handler/>, document.getElementById('react-component')
