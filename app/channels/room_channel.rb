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
    Message.create! email: current_account.email ,content: data['message']
    @lists = Message.where(created_at: 5.second.ago..Time.now) #現時刻から二件

    if @lists.count == 1 then
      ActionCable.server.broadcast 'room_channel', message: "挑戦者があらわれました"
    elsif @lists.count >=   2 then
      first,second = @lists
      @account1 =Account.find_by(email: first.email)
      @account2 =Account.find_by(email: second.email)
      if @account1 != @account2 then
        case first.content
        when "グー" then
          if second.content == "グー" then
            ActionCable.server.broadcast 'room_channel', message: "引き分けなのだ"
            @account1.update(draw: @account1.draw + 1.0)
            @account2.update(draw: @account2.draw + 1.0)

          elsif second.content == "チョキ" then
            ActionCable.server.broadcast 'room_channel', message: @account1.email + " の勝ち"
            @account1.update(win: @account1.win + 1.0)
            @account2.update(lose: @account2.lose + 1.0)
          elsif second.content == "パー" then
            ActionCable.server.broadcast 'room_channel', message: @account2.email + " の勝ち"
            @account2.update(win: @account2.win + 1.0)
            @account1.update(lose: @account1.lose + 1.0)
          end
        when "チョキ" then
          if second.content == "グー" then
            ActionCable.server.broadcast 'room_channel', message: @account2.email + " の勝ち"
            @account2.update(win: @account2.win + 1.0)
            @account1.update(lose: @account1.lose + 1.0)
          elsif second.content == "チョキ" then
            ActionCable.server.broadcast 'room_channel', message: "引き分けなのだ"
            @account1.update(draw: @account1.draw + 1.0)
            @account2.update(draw: @account2.draw + 1.0)
          elsif second.content == "パー" then
            ActionCable.server.broadcast 'room_channel', message: @account1.email + " の勝ち"
            @account1.update(win: @account1.win + 1.0)
            @account2.update(lose: @account2.lose + 1.0)
          end
        when "パー" then
          if second.content == "グー" then
            ActionCable.server.broadcast 'room_channel', message: @account1.email + " の勝ち"
            @account1.update(win: @account1.win + 1.0)
            @account2.update(lose: @account2.lose + 1.0)
          elsif second.content == "チョキ" then
            ActionCable.server.broadcast 'room_channel', message: @account2.email + " の勝ち"
            @account2.update(win: @account2.win + 1.0)
            @account1.update(lose: @account1.lose + 1.0)
          elsif second.content == "パー" then
            ActionCable.server.broadcast 'room_channel', message: "引き分けなのだ"
            @account1.update(draw: @account1.draw + 1.0)
            @account2.update(draw: @account2.draw + 1.0)
          end
        end
        @account1.update(rate: (@account1.win/(@account1.win+ @account1.lose + @account1.draw)).round(3))
        @account2.update(rate: (@account2.win/(@account2.win+ @account2.lose + @account2.draw)).round(3))

      else
        ActionCable.server.broadcast 'room_channel', message: "相手の選択を待っています..."
      end

    end

  end


end
