$ ->

  $('#send_request').click (e) ->
    ID.ui( {method: 'apprequests', redirect_uri: window.location+"/callback", message: $("#request_message").val(), data: "Hidden request data"})
    e.preventDefault()

  $('.send_to_friend').click (e) ->
    friend = $(e.target).data('id')
    ID.ui( {method: 'apprequests', redirect_uri: window.location+"/callback", message: $('#request_message').val(), to: friend} )
    e.preventDefault()

  $('#send_to_all').click (e) ->
    ids = []
    $('.send_to_friend').each (i, el) ->
      ids.push($(el).data('id'))
    friends = ids.join(',')
    ID.ui( {method: 'apprequests', redirect_uri: window.location+"/callback", message: $('#request_message').val(), to: friends} )
    e.preventDefault()
