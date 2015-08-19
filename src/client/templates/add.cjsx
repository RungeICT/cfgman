{Input, Button} = require "react-bootstrap"
React = require "react"

logic = require "../logic"

Popup = require "../shared/popup"


module.exports = React.createClass {
  getInitialState: ->
    {
      value: ""
      show: false
    }

  onChangeValue: () ->
    @setState {
      value: @refs.txtName.getValue()
    }

  onAddClick: () ->
    name = @state.value
    @setState {
      value: ""
      show: false
    }, () =>
      return logic.templates.create name

  onClose: () ->
    @setState {
      show: false
      value: ""
    }

  onShowAdd: () ->
    @setState {
      show: true
    }

  render: () ->
    #return
    popup = undefined
    if @state.show
      buttons = <div>
        <Button onClick={@onClose} bsStyle="warning" bsSize="small">{"Cancel"} <i className={"fa fa-fw fa-ban"} /></Button>
        <Button onClick={@onAddClick} bsStyle="info" bsSize="small">{"Add"}<i className={"fa fa-fw fa-plus"} /></Button>
      </div>
      popup = <Popup onClose={@onClose} title={"Add New Template"} buttons={buttons}>
        <Input ref="txtName" type="text" label="Name" value={@state.value} onChange={@onChangeValue} />
      </Popup>

    return <div>
      <Button onClick={@onShowAdd} bsStyle="info"  bsSize="small">{"Add"}<i className={"fa fa-fw fa-plus"} /></Button>
      {popup}
    </div>


}
