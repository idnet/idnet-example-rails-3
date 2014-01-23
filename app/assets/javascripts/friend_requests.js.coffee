$ ->

  $('.add_friend_button').click (e) ->
    ID.ui({method: 'friends', redirect_uri: "http://localhost:4000/auth/idnet/callback", id: $(this).parent().find('#uid').val()})
    e.preventDefault()
