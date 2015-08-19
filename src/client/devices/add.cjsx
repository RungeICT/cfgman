{Input, Button} = require "react-bootstrap"
React = require "react"

logic = require "../logic"

Popup = require "../shared/popup"
{connect} = require "react-redux"

module.exports = connect(logic.selectors.templateList) React.createClass {
  getInitialState: ->
    {
      templateId: ""
      name: ""
      show: false
    }
  onChangeTemplate: () ->
    @setState {
      templateId: @refs.selTemplates.getValue()
    }
  onChangeName: () ->
    @setState {
      name: @refs.txtName.getValue()
    }

  onConfirmClick: () ->
    name = @state.value
    @setState {
      templateId: ""
      name: ""
      show: false
    }, () =>
      return logic.devices.create name, templateId

  onClose: () ->
    @setState {
      show: false
      name: ""
      templateId: ""
    }

  onShowAdd: () ->
    @setState {
      show: true
    }

  render: () ->
    #return
    popup = undefined
    if @state.show
      templates = [<option value={""}>{"--- Please Select ---"}</option>]
      @props.templates.forEach (v, k) ->
        templates.push <option value={v.id}>{v.name}</option>

      buttons = <div>
        <Button onClick={@onClose} bsStyle="warning" bsSize="small">{"Cancel"} <i className={"fa fa-fw fa-ban"} /></Button>
        <Button onClick={@onAddClick} bsStyle="info" bsSize="small">{"Add"}<i className={"fa fa-fw fa-plus"} /></Button>
      </div>
      popup = <Popup onClose={@onClose} title={"Add New Device"} buttons={buttons}>
        <Input ref="txtName" type="text" label="Name" value={@state.name} onChange={@onChangeValue} />
        <Input ref="selTemplates" type="select" label="Template" value={@state.templateId} onChange={@onChangeTemplate} >
          {templates}
        </Input>
      </Popup>

    return <div>
      <Button onClick={@onShowAdd} bsStyle="info"  bsSize="small">{"Add"}<i className={"fa fa-fw fa-plus"} /></Button>
      {popup}
    </div>


}
