{Col, Row, ListGroup, ListGroupItem, Button} = require "react-bootstrap"
React = require "react"
{ connect  } = require "react-redux"
{devices, selectors, actions} = require "../logic"


module.exports = connect(selectors.deviceList) React.createClass {

  onSelectDevice: (id) ->
    return (e) =>
      return devices.select(id)
  onDeleteDevice: (id) ->
    return (e) =>
      return devices.delete(id)
  onSaveDevice: (id) ->
    return (e) =>
      return devices.save(id)
  render: () ->
    items = []
    @props.devices.forEach (v, k) =>
      style = undefined
      if @props.currentDeviceId == v.id
        style = "info"

      if v.dirty
        saveButton = <Button onClick={@onSaveDevice(v.id)} bsSize="small" bsStyle="primary" className="pull-right" >
          <i className="fa fa-fw fa-floppy-o" />
        </Button>

      items.push <ListGroupItem onClick={@onSelectDevice(v.id)} bsStyle={style} href="javascript:;" key={"template-item-#{k}"}>
        <Row>
          <Col xs={12}>
            <div className="pull-left">{v.name}</div>
            <Button className="pull-right" bsStyle="danger" bsSize="small" onClick={@onDeleteDevice(v.id)}>
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
