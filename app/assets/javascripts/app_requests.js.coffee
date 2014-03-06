$ ->

  $('#send_request').click (e) ->
    ID.ui( {method: 'apprequests', redirect_uri: window.location+"/callback", message: $("#request_message").val(), data: "Hidden request data"})
    e.preventDefault()
