$ ->

  $('#send_request').click (e) ->
    ID.ui('app_request', {redirect_uri: "http://localhost:4000/auth/idnet/callback", message: $("#request_message").val()})
    e.preventDefault()
