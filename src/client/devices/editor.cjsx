React = require "react"
{Row, Col, ButtonToolbar, ButtonGroup, Button} = require "react-bootstrap"
{ connect  } = require "react-redux"
AceEditor  = require('react-ace');
require('brace/mode/ejs')
require('brace/theme/github')

logic = require "../logic"

module.exports = connect(logic.selectors.currentDevice) React.createClass {
  onClickSave: () ->

    logic.templates.save @props.currentDevice.id

  onEditorChange: (data) ->
    {id, name, fieldDefinition} = @props.currentDevice
    if data != @props.currentDevice.data
      logic.templates.modify {
        id, name, fieldDefinition, data
      }



  render: () ->
    if @props.currentDevice?
      if @props.currentDevice.dirty
        saveButton = <Button onClick={@onClickSave} ><i className="fa fa-fw fa-floppy-o" />{"Save"}</Button>

      return <div>
        <Row>
          <Col xs={12}>
            <ButtonToolbar>
              <ButtonGroup>
                {saveButton}
              </ButtonGroup>
            </ButtonToolbar>
          </Col>
        </Row>
        <Row>
          <Col xs={12}>
            <AceEditor mode="ejs" theme="github" name="editor" width="100%" value={@props.currentDevice.data} onChange={@onEditorChange} />
          </Col>
        </Row>
      </div>
    return <div />
}
