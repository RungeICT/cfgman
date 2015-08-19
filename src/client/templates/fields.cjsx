React = require "react"
{Input, Row, Col, Button, Table} = require "react-bootstrap"
{ connect  } = require "react-redux"
logic = require "../logic"




module.exports = connect(logic.selectors.currentTemplate) React.createClass {
  onDeleteField: (key) ->
    () =>
      logic.templates.deleteField(@props.currentTemplate.id, key)
  render: () ->
    if !@props.currentTemplate?
      return <div/>

    rows = []

    for k,v of @props.currentTemplate.fieldDefinition
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
