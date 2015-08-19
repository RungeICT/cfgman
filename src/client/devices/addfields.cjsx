

{Input, Button} = require "react-bootstrap"
React = require "react"

logic = require "../logic"

Popup = require "../shared/popup"





module.exports = React.createClass {
  getInitialState: () ->
    {
      keyValue: ''
      value: "String"
    }
  onKeyChange: () ->
    @setState {
      keyValue: @refs.txtKey.getValue()
    }

  onValueChange: () ->
    @setState {
      value: @refs.selValue.getValue()
    }
  onConfirmClick: () ->
    {keyValue, value} = @state
    @setState {
      keyValue: ""
      value: "String"
      show: false
    }, () =>
      return logic.devices.addField(@props.device.id, keyValue, value)

  onClose: () ->
    @setState {
      keyValue: ""
      value: "String"
      show: false
    }

  onShow: () ->
    @setState {
      show: true
    }

  render: () ->
    #return
    popup = undefined
    if @state.show
      buttons = <div>
        <Button onClick={@onClose} bsStyle="warning" bsSize="small">{"Cancel"} <i className={"fa fa-fw fa-ban"} /></Button>
        <Button onClick={@onConfirmClick} bsStyle="info" bsSize="small">{"Add"}<i className={"fa fa-fw fa-plus"} /></Button>
      </div>
      popup = <Popup onClose={@onClose} title={"Add New Device"} buttons={buttons}>
        <Input ref="txtKey" label="Key Name" type="text" groupClassName="col-xs-12" value={@state.keyValue} onChange={@onKeyChange} />
        <Input ref="selValue" label="Key Type" type="select" groupClassName="col-xs-12" value={@state.value} onChange={@onValueChange}>
          <option value="String">{"String"}</option>
          <option value="parseInt">{"Integer"}</option>
          <option value="parseFloat">{"Float"}</option>
        </Input>
      </Popup>

    return <Button onClick={@onShow} bsStyle="info" bsSize="small">
      {"Add Field"}<i className={"fa fa-fw fa-list-ul"} />
      {popup}
    </Button>


}
