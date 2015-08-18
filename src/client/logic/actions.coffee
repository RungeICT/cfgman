
actionConsts = {
  SET_TEMPLATE: "SET_TEMPLATE"
  SELECT_TEMPLATE: "SELECT_TEMPLATE"
  SET_TEMPLATE_ARR: "SET_TEMPLATE_ARR"
  DELETE_TEMPLATE: "DELETE_TEMPLATE"
  SET_DEVICE: "SET_DEVICE"
  SELECT_DEVICE: "SELECT_DEVICE"
  SET_DEVICE_ARR: "SET_DEVICE_ARR"
  DELETE_DEVICE: "DELETE_DEVICE"
}

module.exports = {
  consts: actionConsts
  SELECT_TEMPLATE: (id) ->
    return {
      name: actionConsts.SELECT_TEMPLATE
      data: { id }
    }
  SET_TEMPLATE: (data) ->
    return {
      name: actionConsts.SET_TEMPLATE
      data: data
    }
  SET_TEMPLATE_ARR: (data) ->
    return {
      name: actionConsts.SET_TEMPLATE_ARR
      data: data
    }
  DELETE_TEMPLATE: (id) ->
    return {
      name: actionConsts.DELETE_TEMPLATE
      data: {id}
    }
  SELECT_DEVICE: (id) ->
    return {
      name: actionConsts.SELECT_DEVICE
      data: { id }
    }
  SET_DEVICE: (data) ->
    return {
      name: actionConsts.SET_DEVICE
      data: data
    }
  SET_DEVICE_ARR: (data) ->
    return {
      name: actionConsts.SET_DEVICE_ARR
      data: data
    }
  DELETE_DEVICE: (id) ->
    return {
      name: actionConsts.DELETE_DEVICE
      data: {id}
    }

}
