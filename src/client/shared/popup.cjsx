
React = require "react"
{Modal, Row, Col} = require "react-bootstrap"
module.exports = React.createClass {

  getDefaultProps: ->
    {
      title: ""
      buttons: undefined
      onClose: undefined
    }

  getInitialState: () ->
    {

    }


  render: () ->
    return <Modal show={true} onHide={@props.onClose} animation={false}  aria-labelledby='contained-modal-title'>
      <Modal.Header closeButton>
        <Modal.Title id='contained-modal-title'>{@props.title}</Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <Row>
          <Col xs={12}>
            {@props.children}
          </Col>
        </Row>
      </Modal.Body>
      <Modal.Footer>
        {@props.buttons}
      </Modal.Footer>
    </Modal>


}
