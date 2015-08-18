React = require "react"
Immutable = require "immutable"
{ Provider  } = require "react-redux"
{Col, Row} = require "react-bootstrap"
#------ Controls
DeviceList = require "./list"
DeviceEditor = require "./editor"
DeviceAdd = require "./add"
DeviceFields = require "./fields"

{store, templates} = require "../logic"

App = React.createClass {
  render: () ->
    <div className="container-fluid">
      <Row>
        <Col xs={12} sm={4} md={2}>
          <Row>
            <Col xs={12}>
              <DeviceAdd />
            </Col>
          </Row>
          <Row>
            <Col xs={12}>
              <DeviceList />
            </Col>
          </Row>
        </Col>
        <Col xs={12} sm={7}>
          <DeviceEditor />
        </Col>
        <Col xs={12} md={3}>
          <DeviceFields />
        </Col>
      </Row>
    </div>

}


module.exports = React.createClass {

  componentWillMount: () ->
    templates.load()

  initFunc: ->
    return <App />

  render: () ->
    <Provider store={store}>
      {@initFunc}
    </Provider>
}
