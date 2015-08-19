React = require "react"
{Row, Col, ButtonToolbar, ButtonGroup, Button} = require "react-bootstrap"
{ connect  } = require "react-redux"
Panel = require "../shared/panel"
TemplateFields = require "./fields"
DeleteTemplateButton = require "./delete"
AddFieldsButton = require "./addfields"
#AceEditor  = require('react-ace');
AceEditor = require "../shared/ace"
require('brace/mode/ejs')
require('brace/theme/monokai')
logic = require "../logic"

module.exports = connect(logic.selectors.currentTemplate) React.createClass {
  onClickSave: () ->
    logic.templates.save @props.currentTemplate.id

  onEditorChange: (data) ->
    {id, name, fieldDefinition} = @props.currentTemplate
    if data != @props.currentTemplate.data
      logic.templates.modify {
        id, name, fieldDefinition, data
      }

  onClickDelete: () ->
    logic.templates.delete @props.currentTemplate.id

  render: () ->
    if @props.currentTemplate?
      if @props.currentTemplate.dirty
        saveButton = <ButtonGroup>
          <Button onClick={@onClickSave} bsSize="small" bsStyle="primary" >{"Save"}<i className="fa fa-fw fa-floppy-o" /></Button>
        </ButtonGroup>

      headerRight = <div>
        <ButtonToolbar>
          <ButtonGroup>
            <AddFieldsButton template={@props.currentTemplate} />
          </ButtonGroup>
          <ButtonGroup>
            <DeleteTemplateButton template={@props.currentTemplate} noText={false} />
          </ButtonGroup>
          {saveButton}
        </ButtonToolbar>
      </div>
      return <div>
        <Panel headerLeft={@props.currentTemplate.name} headerRight={headerRight}>
          <Row>
            <Col xs={12} sm={8} md={9}>
                <AceEditor
                  key="#{@props.currentTemplate.id}-editor"
                  mode="ejs"
                  theme="monokai"
                  name="editor"
                  style= {
                    width: "100%"
                    minHeight: 400
                  }
                  onSaveCommand={@onClickSave}
                  value={@props.currentTemplate.data}
                  isReadOnly={false} onChange={@onEditorChange} />
            </Col>
            <Col xs={12} sm={4} md={3}>
              <Panel>
                <TemplateFields />
              </Panel>
            </Col>
          </Row>
        </Panel>
      </div>
    return <div />
}
