class RoomsController < ApplicationController
  def show
    @messages = Message.all
    @temp = Message.where("created_at>'2016-07-19 10:41:18 UTC'")
  end 
end
