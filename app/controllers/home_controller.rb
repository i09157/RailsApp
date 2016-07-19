class HomeController < ApplicationController
# before_action :authenticate_account!,only: :authentication 
  def index
    @user = User.find_by(:id => current_account.id)
  end

  def authentication
  end
  
  
end
