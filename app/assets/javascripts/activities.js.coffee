# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  $('#site_feed_form').submit (e) ->
    params = $(this).serializeArray()
    object = { method: 'feed' }
    for el in params
      do ->
        object[el['name']] = el['value']

    ID.ui(object)
    e.preventDefault()
