class HomeController < ApplicationController
 before_action :authenticate_account!,only: :authentication
  def index
     if account_signed_in?
       current_account.update(win: 0.0) if current_account.win == nil
       current_account.update(draw: 0.0) if current_account.draw == nil
       current_account.update(lose: 0.0) if current_account.lose == nil
     end
    @accounts = Account.all
  end


  def authentication
  end
end
