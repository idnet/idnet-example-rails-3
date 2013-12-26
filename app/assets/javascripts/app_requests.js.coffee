$ ->

  $('#send_request').click (e) ->
    ID.ui('app_request', {redirect_uri: window.location.protocol + '//' + window.location.host + "/app_requests/callback", message: $("#request_message").val()})
    e.preventDefault()
