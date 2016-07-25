App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    @room_connect()
  # # Called when the WebSocket connection is closed
  # disconnected: ->
    # @disappear()
  # # Called when the subscription is rejected by the server

  room_connect: ->
    @perform 'room_connect'
    # @perform 'appear', name: current_account.email

  # disappear: ->
    # @perform 'disappear'
    # @perform 'appear', name: current_account.email

  received: (data) ->
    $('#messages').append data['message']
    $('#times').text(data['time'])

  speak:(message) ->
      @perform 'speak', message: message

  timer:(time) ->
    @perform 'timer', time: time

  #time
  window.min=0
  window.sec=5
  countDown = ->
    window.min=parseInt window.min
    window.sec=parseInt window.sec
    tmWrite(window.sec-1)
    #alert("time")
    return

  cntStart = ->
    window.document.timer.btn.value.disable=true
    window.timer1=setInterval(countDown,1000)
    # window.flug = true
    return

  tmWrite = (int) ->
    int=parseInt(int)
    if int <= -1
      reSet()
      #alert("時間です！")
    else
      window.min=Math.floor(int/60)
      window.sec=int % 60
      App.room.timer window.sec
      #App.room.speak window.sec
    return

  reSet = ->
    App.room.timer window.sec
    window.min=0
    window.sec=5
    App.room.timer window.sec
    window.document.timer.btn.value.disable=false
    clearInterval(window.timer1)
    window.timer1=''
    return

  $(document).on 'click', '[data-behavior~=room_timer]', (event)->
    cntStart()
    event.preventDefault()


  $(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
    if event.keyCode is 13 # return = send
        App.room.speak event.target.value
        # event.target.value = ''
        event.preventDefault()
