class RoomsController < ApplicationController
  def show
    @time = Time.now
    @messages = Message.all
    @temp = Message.where("created_at>@time")
  end

  def start
    @start = Time.now
  end

end
