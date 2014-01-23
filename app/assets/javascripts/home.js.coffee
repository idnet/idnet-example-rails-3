# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  options = { method: 'feed', app_id: '<%= APP_CONFIG[:app_id] %>',
  site_feed: { caption: 'Share info...', name: 'ID.org', link: 'http://id.org',
  picture: 'https://cdn1.iconfinder.com/data/icons/socialite/500/fb.png',
  description: 'Share some social information on ID.org about activities, games, fun, etc.'} }

  $('#share_feed').click (e) ->
    ID.ui options
    e.preventDefault()
