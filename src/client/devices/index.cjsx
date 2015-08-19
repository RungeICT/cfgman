React = require "react"
Immutable = require "immutable"
{Col, Row} = require "react-bootstrap"
#------ Controls
DeviceList = require "./list"
DeviceEditor = require "./editor"
DeviceAdd = require "./add"

Panel = require "../shared/panel"

module.exports = React.createClass {
  render: () ->
    headerRight = <DeviceAdd />
    <div className="container-fluid">
      <Row>
        <Col xs={12} sm={4} md={2}>
          <Panel headerLeft={"Devices"} headerRight={headerRight}>
            <Row>
              <Col xs={12}>
                <DeviceList />
              </Col>
            </Row>
          </Panel>
        </Col>
        <Col xs={12} sm={8} md={10}>
          <DeviceEditor/>
        </Col>
      </Row>
    </div>

}
