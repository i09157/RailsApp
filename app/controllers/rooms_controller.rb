class RoomsController < ApplicationController
  def show
    @messages = Message.all
    @lines = Message.where(created_at: 5.second.ago..Time.now)
  end

end
