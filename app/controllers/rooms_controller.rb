class RoomsController < ApplicationController
  def show
    @messages = Message.all
    @lists = Message.where(created_at: 10.second.ago..Time.now)

    if @lists.count == 2 then #じゃんけん判定
       first,second = @lists
       flash.now[:first] = "first:#{first.content}"
       flash.now[:second] = "second:#{second.content}"
       @account1 =Account.find_by(email: first.email)
       @account2 =Account.find_by(email: second.email)


       if first.content == "グー" then
          if second.content == "チョキ" then
            flash.now[:result] = first.email + ":win:" + first.content + "vs" + second.content
            @account1.update(win: @account1.win + 1.0)
            @account2.update(lose: @account2.lose + 1.0)

          elsif second.content == "パー" then
            flash.now[:result] = second.email + ":win" + first.content + "vs" + second.content
            @account2.update(win: @account2.win + 1.0)
            @account1.update(lose: @account1.lose + 1.0)

          elsif second.content == "グー" then
            flash.now[:result] = "draw" + first.content + "vs" + second.content
            @account1.update(draw: @account1.draw + 1.0)
            @account2.update(draw: @account2.draw + 1.0)

          end
       elsif first.content == "チョキ" then
          if second.content == "パー" then
            flash.now[:result] = first.email + ":win" + first.content + "vs" + second.content
            @account1.update(win: @account1.win + 1.0)
            @account2.update(lose: @account2.lose + 1.0)

          elsif second.content == "グー" then
            flash.now[:result] = second.email + ":win" + first.content + "vs" + second.content
            @account2.update(win: @account2.win + 1.0)
            @account1.update(lose: @account1.lose + 1.0)

          elsif second.content == "チョキ" then
            flash.now[:result] = "draw" + first.content + "vs" + second.content
            @account1.update(draw: @account1.draw + 1.0)
            @account2.update(draw: @account2.draw + 1.0)

          end
       elsif first.content == "パー" then
         if second.content == "グー" then
           flash.now[:result] = first.email + ":win" + first.content + "vs" + second.content
           @account1.update(win: @account1.win + 1.0)
           @account2.update(lose: @account2.lose + 1.0)

         elsif second.content == "チョキ" then
           flash.now[:result] = second.email + ":win" + first.content + "vs" + second.content
           @account2.update(win: @account2.win + 1.0)
           @account1.update(lose: @account1.lose + 1.0)

          elsif second.content == "パー" then
           flash.now[:result] = "draw" + first.content + "vs" + second.content
           @account1.update(draw: @account1.draw + 1.0)
           @account2.update(draw: @account2.draw + 1.0)
         end
       end

       @account1.update(rate: (@account1.win/(@account1.win+ @account1.lose + @account1.draw)).round(3))
       @account2.update(rate: (@account2.win/(@account2.win+ @account2.lose + @account2.draw)).round(3))

    end
  end
end
