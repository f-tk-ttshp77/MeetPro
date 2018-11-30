document.addEventListener 'turbolinks:load', ->
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: $('#messages').data('room_id') },
    connected: ->

    disconnected: ->

    received: (data) ->
      $('#messages').append data['message']
      wholeHeight = $('#messages').get(0).scrollHeight
      displayHeight = $('#messages').height()
      $('#messages').scrollTop(wholeHeight - displayHeight)

    speak: (message, msgtype)->
      @perform 'speak', message: message, msgtype: msgtype

  if document.URL.match("/rooms")
    wholeHeight = $('#messages').get(0).scrollHeight
    displayHeight = $('#messages').height()
    $('#messages').scrollTop(wholeHeight - displayHeight)

  $(document).off 'keypress', '[data-behavior~=room_speaker]'
  $(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
    if event.keyCode is 13 # return = send
      App.room.speak event.target.value, $('.flag').attr('name')
      event.target.value = ''
      event.target.name = '1'
      $('.flag').removeClass('flag chosen')
      $('.start').addClass('flag chosen')
      event.preventDefault()

$(document).on 'keydown', '[data-behavior~=room_speaker]', (event) ->
  if event.metaKey || event.ctrlKey
    if event.keyCode is 39 #[→]キー
      if $('.flag').hasClass('edge1')
        $('.flag').removeClass('chosen')
        $('.flag').next().next().addClass('chosen')
        $('.chosen').prev().prev().removeClass('flag')
        $('.chosen').addClass('flag')
      else if !($('.flag').hasClass('end'))
        $('.flag').removeClass('chosen')
        $('.flag').next().addClass('chosen')
        $('.chosen').prev().removeClass('flag')
        $('.chosen').addClass('flag')
    else if event.keyCode is 37 #[←]キー
      if $('.flag').hasClass('edge2')
        $('.flag').removeClass('chosen')
        $('.flag').prev().prev().addClass('chosen')
        $('.chosen').next().next().removeClass('flag')
        $('.chosen').addClass('flag')
      else if !($('.flag').hasClass('start'))
        $('.flag').removeClass('chosen')
        $('.flag').prev().addClass('chosen')
        $('.chosen').next().removeClass('flag')
        $('.chosen').addClass('flag')
    else if event.keyCode is 40 #[↓]キー
      if $('.flag').hasClass('downline1')
        $('.flag').removeClass('chosen')
        $('.flag').next().next().next().next().next().next().next().next().next().addClass('chosen')
        $('.chosen').prev().prev().prev().prev().prev().prev().prev().prev().prev().removeClass('flag')
        $('.chosen').addClass('flag')
      else if $('.flag').hasClass('downline2')
        $('.flag').removeClass('chosen')
        $('.flag').next().next().next().next().next().next().next().next().addClass('chosen')
        $('.chosen').prev().prev().prev().prev().prev().prev().prev().prev().removeClass('flag')
        $('.chosen').addClass('flag')
      else if $('.flag').hasClass('downline3')
        $('.flag').removeClass('chosen')
        $('.flag').next().next().next().next().next().next().next().addClass('chosen')
        $('.chosen').prev().prev().prev().prev().prev().prev().prev().removeClass('flag')
        $('.chosen').addClass('flag')
    else if event.keyCode is 38 #[↑]キー
      if $('.flag').hasClass('upline1')
        $('.flag').removeClass('chosen')
        $('.flag').prev().prev().prev().prev().prev().prev().prev().prev().prev().addClass('chosen')
        $('.chosen').next().next().next().next().next().next().next().next().next().removeClass('flag')
        $('.chosen').addClass('flag')
      else if $('.flag').hasClass('upline2')
        $('.flag').removeClass('chosen')
        $('.flag').prev().prev().prev().prev().prev().prev().prev().prev().addClass('chosen')
        $('.chosen').next().next().next().next().next().next().next().next().removeClass('flag')
        $('.chosen').addClass('flag')
