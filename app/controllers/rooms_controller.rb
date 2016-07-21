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
            flash.now[:result] = first.email + ":fist win"
            # @account1.user.win += 1.0一致したユーザにwin１加算
          elsif second.content == "パー" then
            flash.now[:result] = second.email + ":second win"
          else
            flash.now[:result] = "draw"
          end
       elsif first.content == "チョキ" then
          if second.content == "パー" then
            flash.now[:result] = "first win"
          elsif second.content == "グー" then
            flash.now[:result] = "second win"
          else
            flash.now[:result] = "draw"
          end
       else
         if second.content == "グー" then
           flash.now[:result] = "first win"
         elsif second.content == "チョキ" then
           flash.now[:result] = "second win"
         else
           flash.now[:result] = "draw"
         end
       end

    end
  end
end
