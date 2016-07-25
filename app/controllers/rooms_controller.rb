class RoomsController < ApplicationController
  def show
    @messages = Message.all
    @temp = Message.where("created_at")
  end
end
