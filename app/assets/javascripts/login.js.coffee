$ ->

  # Bind login clicks in links

  $('#popup-login').click (e) ->
   open_idnet_signin_signup('/auth/idnet')
   e.preventDefault()

  $('#smart-login').click (e) ->
    _idapi.push ['login']


  $('#sdk-login').click (e) ->
    ID.login (response) ->
      console.log(response)
