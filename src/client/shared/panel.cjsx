React = require "react"
{Panel, Row, Col} = require "react-bootstrap"
module.exports = React.createClass {
  render: ->
    header = undefined
    if @props.headerLeft? || @props.headerRight?
      header = <h3>
        <Row>
          <Col xs={12}>
            <div className="pull-left">
              {@props.headerLeft}
            </div>
            <div className="pull-right">
              {@props.headerRight}
            </div>
          </Col>
        </Row>
      </h3>
    return <Panel {...@props} header={header}>
      {@props.children}
    </Panel>


}
