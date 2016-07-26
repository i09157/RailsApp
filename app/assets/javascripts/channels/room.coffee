App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    @room_connect()

  room_connect: ->
    @perform 'room_connect'


  received: (data) ->
    $('#messages').append data['message']
    $('#times').text(data['time'])


  speak:(message) ->
      @perform 'speak', message: message

  timer:(time) ->
    @perform 'timer', time: time


  countDown = ->
    window.sec=parseInt window.sec
    tmWrite(window.sec-1)
    return

  cntStart = ->
    # window.document.timer.btn.value.disable=true
    window.sec=5
    App.room.timer window.sec
    window.timer1=setInterval(countDown,1000)
    return

  tmWrite = (int) ->
    int=parseInt(int)
    if int <= -1
      reSet()
      #alert("時間です！")
    else
      window.sec=int % 60
      App.room.timer window.sec
    return

  reSet = ->
    # window.document.timer.btn.value.disable=false
    clearInterval(window.timer1)
    window.timer1=''

    return

  $(document).on 'click', '[data-behavior~=room_timer]', (event)->
    cntStart()
    event.preventDefault()
    window.flug = 1

  $(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
    if event.keyCode is 13 and window.flug is 1# return = send
        App.room.speak event.target.value
        # event.target.value = ''
        window.flug = 0
        event.preventDefault()
