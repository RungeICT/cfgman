React = require "react"
Immutable = require "immutable"
{Col, Row} = require "react-bootstrap"
#------ Controls
TemplateList = require "./list"
TemplateEditor = require "./editor"
TemplateAdd = require "./add"

Panel = require "../shared/panel"

module.exports = React.createClass {
  render: () ->
    headerRight = <TemplateAdd />
    <div className="container-fluid">
      <Row>
        <Col xs={12} sm={4} md={2}>
          <Panel headerLeft={"Templates"} headerRight={headerRight}>
            <Row>
              <Col xs={12}>
                <TemplateList />
              </Col>
            </Row>
          </Panel>
        </Col>
        <Col xs={12} sm={8} md={10}>
          <TemplateEditor/>
        </Col>
      </Row>
    </div>

}
