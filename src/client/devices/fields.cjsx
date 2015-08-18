React = require "react"
{Input, Row, Col, Button, Table} = require "react-bootstrap"
{ connect  } = require "react-redux"
logic = require "../logic"

AddRecord = React.createClass {
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
  onAddField: () ->
    {keyValue, value} = @state
    @setState {
      keyValue: ""
      value: "String"
    }, () =>
      return logic.devices.addField(@props.id, keyValue, value)



  render: () ->
    <Row>
      <Input ref="txtKey" label="Key Name" type="text" groupClassName="col-xs-12" value={@state.keyValue} onChange={@onKeyChange} />
      <Input ref="selValue" label="Key Type" type="select" groupClassName="col-xs-12" value={@state.value} onChange={@onValueChange}>
        <option value="String">{"String"}</option>
        <option value="parseInt">{"Integer"}</option>
        <option value="parseFloat">{"Float"}</option>
      </Input>
      <Button onClick={@onAddField} bsSize="small" bsStyle="primary" className="col-xs-12"><i className="fa fa-fw fa-floppy-o"/>{"Add"}</Button>
    </Row>
}





module.exports = connect(logic.selectors.currentDevice) React.createClass {
  onDeleteField: (key) ->
    () =>
      logic.devices.deleteField(@props.currentDevice.id, key)
  render: () ->
    if !@props.currentDevice?
      return <div/>

    rows = []

    for k,v of @props.currentDevice.fieldDefinition
      rows.push <tr key={"field-#{k}"}>
        <td>
          {k}
        </td>
        <td>
          {v}
        </td>
        <td>
          <Button onClick={@onDeleteField(k)} bsSize="small" bsStyle="primary" className="col-xs-12">
            <i className="fa fa-fw fa-trash-o"/>
          </Button>
        </td>
      </tr>

    return <div>
      <AddRecord key="newFields" id={@props.currentDevice.id} />
      <Table>
        <thead>
          <th>
            {"Key Name"}
          </th>
          <th>
            {"Key Type"}
          </th>
          <th></th>
        </thead>
        <tbody>
          {rows}
        </tbody>
      </Table>
    </div>

}
