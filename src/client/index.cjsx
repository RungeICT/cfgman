require("./util/promise-poly")()


Templates = require "./templates"
Devices = require "./devices"
React = require "react"
Router = require "react-router"
{Route, DefaultRoute, RouteHandler} = Router

{NavItemLink} = require "react-router-bootstrap"
{ Navbar, Nav} = require "react-bootstrap"
App = React.createClass {
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

routes = <Route name="app" path="/" handler={App}>
  <DefaultRoute handler={Templates}/>
  <Route path="/devices" handler={Devices} />
</Route>

Router.run routes, Router.HistoryLocation, (Handler) ->
  React.render <Handler/>, document.getElementById('react-component')
