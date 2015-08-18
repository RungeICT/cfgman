React = require "react"
Immutable = require "immutable"
{ Provider  } = require "react-redux"
{Col, Row} = require "react-bootstrap"
#------ Controls
TemplateList = require "./list"
TemplateEditor = require "./editor"
TemplateAdd = require "./add"
TemplateFields = require "./fields"

{store, templates} = require "./logic"


App = React.createClass {
  render: () ->
    <div className="container-fluid">
      <Row>
        <Col xs={12} sm={4} md={2}>
          <Row>
            <Col xs={12}>
              <TemplateAdd />
            </Col>
          </Row>
          <Row>
            <Col xs={12}>
              <TemplateList />
            </Col>
          </Row>
        </Col>
        <Col xs={12} sm={8}>
          <TemplateEditor />
        </Col>
        <Col xs={12} md={2}>
          <TemplateFields />
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
