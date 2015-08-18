{Col, Row, ListGroup, ListGroupItem, Button} = require "react-bootstrap"
React = require "react"
{ connect  } = require "react-redux"
{templates, selectors, actions} = require "./logic"


module.exports = connect(selectors.templateList) React.createClass {

  onSelectTemplate: (id) ->
    return (e) =>
      return templates.select(id)
  onDeleteTemplate: (id) ->
    return (e) =>
      return templates.delete(id)
  onSaveTemplate: (id) ->
    return (e) =>
      return templates.save(id)
  render: () ->
    items = []
    @props.templates.forEach (v, k) =>
      style = undefined
      if @props.currentTemplateId == v.id
        style = "info"

      if v.dirty
        saveButton = <Button onClick={@onSaveTemplate(v.id)} bsSize="small" bsStyle="primary" className="pull-right" >
          <i className="fa fa-fw fa-floppy-o" />
        </Button>

      items.push <ListGroupItem onClick={@onSelectTemplate(v.id)} bsStyle={style} href="javascript:;" key={"template-item-#{k}"}>
        <Row>
          <Col xs={12}>
            <div className="pull-left">{v.name}</div>
            <Button className="pull-right" bsStyle="danger" bsSize="small" onClick={@onDeleteTemplate(v.id)}>
              <i className="fa fa-fw fa-trash-o"/>
            </Button>
            {saveButton}
          </Col>
        </Row>
      </ListGroupItem>
    return <ListGroup>
      {items}
    </ListGroup>
}
