# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
    stream_for current_account
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end


  def speak(data) #クライアントサイドから送信されたメッセージを受信
      if @first.nil? then
        @first = data['message']
        @first_email = current_account.email
        ActionCable.server.broadcast 'room_channel', message: @first_email
      else
        case @first
        when "グー" then
          if data['message'] == "グー" then
            ActionCable.server.broadcast 'room_channel', message: "引き分けなのだ"
            @first = nil
          elsif data['message'] == "チョキ" then
            ActionCable.server.broadcast 'room_channel', message: "先攻の勝ち"
            @first = nil
          elsif data['message'] == "パー" then
            ActionCable.server.broadcast 'room_channel', message: "後攻の勝ち"
            @first = nil
          end
        when "チョキ" then
          if data['message'] == "グー" then
            ActionCable.server.broadcast 'room_channel', message: "後攻の勝ち"
            @first = nil
          elsif data['message'] == "チョキ" then
            ActionCable.server.broadcast 'room_channel', message: "引き分けなのだ"
            @first = nil
          elsif data['message'] == "パー" then
            ActionCable.server.broadcast 'room_channel', message: "先攻の勝ち"
            @first = nil
          end
        when "パー" then
          if data['message'] == "グー" then
            ActionCable.server.broadcast 'room_channel', message: "先攻の勝ち"
            @first = nil
          elsif data['message'] == "チョキ" then
            ActionCable.server.broadcast 'room_channel', message: "後攻の勝ち"
            @first = nil
          elsif data['message'] == "パー" then
            ActionCable.server.broadcast 'room_channel', message: "引き分けなのだ"
            @first = nil
          end
        end
      end
      Message.create! email: current_account.email ,content: data['message']

  end


end
