class HomeController < ApplicationController
# before_action :authenticate_account!,only: :authentication 
  def index
    @user = User.find_by(:id => current_account.id)
    if @user == nil
        @user = User.new(id: current_account.id, name:current_account.email,win:0.0, lose:0.0, draw:0.0)
        @user.save(:validate => false)
    end
  end

  def authentication
  end
  
  
end
