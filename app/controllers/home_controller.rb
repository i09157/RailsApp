class HomeController < ApplicationController
 before_action :authenticate_account!,only: :authentication
  def index
     if account_signed_in?
       current_account.update(win: 0.0) if current_account.win == nil
       current_account.update(draw: 0.0) if current_account.draw == nil
       current_account.update(lose: 0.0) if current_account.lose == nil
       current_account.update(rate: 0.0) if current_account.rate == nil
     end
    # @accounts = Account.all
    @search = Account.search(params[:q])
    @accounts = @search.result

    respond_to do |format|
      format.html
      format.json {render json: @accounts}
    end
  end

  def authentication
  end
end
