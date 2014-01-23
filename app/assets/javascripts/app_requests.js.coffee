$ ->

  $('#send_request').click (e) ->
    ID.ui( {method: 'apprequests', redirect_uri: "http://localhost:4000/auth/idnet/callback", message: $("#request_message").val()})
    e.preventDefault()
