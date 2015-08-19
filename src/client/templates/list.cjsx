{Col, Row, ListGroup, ListGroupItem, Button, ButtonGroup, ButtonToolbar} = require "react-bootstrap"
React = require "react"
{ connect  } = require "react-redux"
{templates, selectors, actions} = require "../logic"
{Navigation} = require "react-router"
DeleteTemplate = require "./delete"



module.exports = connect(selectors.templateList) React.createClass {
  mixins: [Navigation]
  onSelectTemplate: (id) ->
    return (e) =>
      return @transitionTo "/templates/#{id}"
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
        saveButton = <Button onClick={@onSaveTemplate(v.id)} bsSize="small" bsStyle="primary" >
          <i className="fa fa-fw fa-floppy-o" />
        </Button>

      items.push <ListGroupItem onClick={@onSelectTemplate(v.id)} bsStyle={style} href="javascript:;" key={"template-item-#{k}"}>
        <Row>
          <Col xs={12}>
            <div className="pull-left">{v.name}</div>
            <ButtonToolbar className="pull-right">
              <ButtonGroup>
                <DeleteTemplate template={v} noText={true} />
                {saveButton}
              </ButtonGroup>
            </ButtonToolbar>
          </Col>
        </Row>
      </ListGroupItem>
    return <ListGroup>
      {items}
    </ListGroup>
}
