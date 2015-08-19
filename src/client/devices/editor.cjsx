React = require "react"
{Row, Col, ButtonToolbar, ButtonGroup, Button} = require "react-bootstrap"
{ connect  } = require "react-redux"
Panel = require "../shared/panel"
DeviceFields = require "./fields"
DeleteDeviceButton = require "./delete"
AddFieldsButton = require "./addfields"
#AceEditor  = require('react-ace');
AceEditor = require "../shared/ace"

logic = require "../logic"

module.exports = connect(logic.selectors.currentDevice) React.createClass {
  onClickSave: () ->
    logic.devices.save @props.currentDevice.id

  onEditorChange: (data) ->
    {id, name, fieldDefinition} = @props.currentDevice
    if data != @props.currentDevice.data
      logic.devices.modify {
        id, name, fieldDefinition, data
      }

  onClickDelete: () ->
    logic.devices.delete @props.currentDevice.id

  render: () ->
    if @props.currentDevice?
      if @props.currentDevice.dirty
        saveButton = <ButtonGroup>
          <Button onClick={@onClickSave} bsSize="small" bsStyle="primary" >{"Save"}<i className="fa fa-fw fa-floppy-o" /></Button>
        </ButtonGroup>

      headerRight = <div>
        <ButtonToolbar>
          <ButtonGroup>
            <AddFieldsButton device={@props.currentDevice} />
          </ButtonGroup>
          <ButtonGroup>
            <DeleteDeviceButton device={@props.currentDevice} noText={false} />
          </ButtonGroup>
          {saveButton}
        </ButtonToolbar>
      </div>
      return <div>
        <Panel headerLeft={@props.currentDevice.name} headerRight={headerRight}>
          <Row>
            <Col xs={12} sm={8} md={9}>
                <AceEditor
                  key="#{@props.currentDevice.id}-editor"
                  mode="ejs"
                  theme="github"
                  name="editor"
                  style= {
                    width: "100%"
                    minHeight: 400
                  }
                  value={@props.currentDevice.data}
                  isReadOnly={false} onChange={@onEditorChange} />
            </Col>
            <Col xs={12} sm={4} md={3}>
              <Panel>
                <DeviceFields />
              </Panel>
            </Col>
          </Row>
        </Panel>
      </div>
    return <div />
}
