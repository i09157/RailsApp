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

  speak:(message) ->
      @perform 'speak', message: message

$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
    if event.keyCode is 13 # 押されたキーがエンターキーなら
        App.room.speak event.target.value
        # event.target.value = ''
        event.preventDefault()
