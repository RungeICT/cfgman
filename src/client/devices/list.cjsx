{Col, Row, ListGroup, ListGroupItem, Button, ButtonGroup, ButtonToolbar} = require "react-bootstrap"
React = require "react"
{ connect  } = require "react-redux"
{devices, selectors, actions} = require "../logic"

DeleteDevice = require "./delete"



module.exports = connect(selectors.deviceList) React.createClass {

  onSelectDevice: (id) ->
    return (e) =>
      return devices.select(id)
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
        saveButton = <Button onClick={@onSaveDevice(v.id)} bsSize="small" bsStyle="primary" >
          <i className="fa fa-fw fa-floppy-o" />
        </Button>

      items.push <ListGroupItem onClick={@onSelectDevice(v.id)} bsStyle={style} href="javascript:;" key={"device-item-#{k}"}>
        <Row>
          <Col xs={12}>
            <div className="pull-left">{v.name}</div>
            <ButtonToolbar className="pull-right">
              <ButtonGroup>
                <DeleteDevice device={v} noText={true} />
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
