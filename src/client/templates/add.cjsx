{Input, Button} = require "react-bootstrap"
React = require "react"

logic = require "../logic"


module.exports = React.createClass {
  getInitialState: ->
    {
      value: ""
    }

  onChangeValue: () ->
    @setState {
      value: @refs.txtName.getValue()
    }

  onAddClick: () ->
    name = @state.value
    @setState {
      value: ""
    }, () =>
      return logic.templates.create name

  render: () ->
    button = <Button onClick={@onAddClick} bsStyle="info">{"Add"}</Button>
    return <Input ref="txtName" type="text" buttonAfter={button} label="Name" value={@state.value} onChange={@onChangeValue} />

}
