React = require "react"
{Input, Row, Col, Button} = require "react-bootstrap"
{ connect  } = require "react-redux"
logic = require "./logic"

AddRecord = React.createClass {
  getInitialState: () ->
    {
      keyValue: ''
      value: "String"
    }
  onKeyChange: () ->
    @setState {
      keyValue: @ref.txtKey.getValue()
    }

  onValueChange: () ->
    @setState {
      value: @ref.selValue.getValue()
    }
  onAddField: () ->
    {keyValue, value} = @state
    @setState {
      keyValue: ""
      value: "String"
    }, () =>
      return logic.templates.addField(@props.id, key, value)



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





module.exports = connect(logic.selectors.currentTemplate) React.createClass {
  onDeleteField: (key) ->
    () =>
      logic.templates.deleteField(@props.currentTemplate.id, key, value)
  render: () ->
    if !@props.currentTemplate?
      return <div/>

    rows = [<AddRecord key="newFields" id={@props.currentTemplate.id} />]
    for k,v in @props.currentTemplate.fieldDefinition
      rows.push <Row key={"field-#{k}"}>
        <Col xs={5}>
          {k}
        </Col>
        <Col xs={5}>
          {v}
        </Col>
        <Button onClick={@onDeleteField(k)} bsSize="small" bsStyle="primary" className="col-xs-offset-1 col-xs-1"><i className="fa fa-fw fa-trash-o"/></Button>
      </Row>
    <div>
      {rows}
    </div>

}
