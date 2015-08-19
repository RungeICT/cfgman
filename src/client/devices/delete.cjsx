{Input, Button} = require "react-bootstrap"
React = require "react"

logic = require "../logic"

Popup = require "../shared/popup"


module.exports = React.createClass {
  getInitialState: ->
    {
      show: false
    }

  onConfirmClick: () ->
    @setState {
      show: false
    }, () =>
      return logic.devices.delete(@props.device.id)

  onClose: () ->
    @setState {
      show: false
    }

  onShow: (e) ->
    e.stopPropagation()
    @setState {
      show: true
    }

  render: () ->
    #return
    popup = undefined
    if @state.show
      buttons = <div>
        <Button onClick={@onClose} bsStyle="info" bsSize="small">{"Cancel"} <i className={"fa fa-fw fa-smile-o"} /></Button>
        <Button onClick={@onConfirmClick} bsStyle="danger" bsSize="small">{"Confirm"}<i className={"fa fa-fw fa-ban"} /></Button>
      </div>
      popup = <Popup onClose={@onClose} title={"Delete '#{@props.device.name}'"} buttons={buttons}>
        {"Are you sure you want to delete the device '#{@props.device.name}'?"}
      </Popup>

    if !@props.noText
      text = "Delete"
    return <Button onClick={@onShow} bsStyle="danger" bsSize="small">{text}<i className={"fa fa-fw fa-trash-o"} />
      {popup}
    </Button>


}
