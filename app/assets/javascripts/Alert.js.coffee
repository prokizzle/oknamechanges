class @Alert

  @_message: (level, errorMsg) ->
    errorMsgTemplate = JST["error_template"]
    $('#errorBoxPlace').html(errorMsgTemplate({msg: errorMsg, level: level}))
    $('#errorBoxPlace').show()
    return

  @error: (msg) ->
    Alert._message "alert", msg
    return
  @notice: (msg) ->
    Alert._message "notice", msg
    return
  @success: (msg) ->
    Alert._message "success", msg
    return
  @clear: ->
    $('#errorBoxPlace').slideUp()
    $('#errorBoxPlace').html("")
    $('#errorBoxPlace').slideDown()
    return
  messages:
    noCurrentPassword: "Please enter your current password"
    mismatchedPasswords: "Passwords do not match"

$(document).ready ->
  $('#errorBoxPlace').on "click", ->
    Alert.clear()
    return false
return
