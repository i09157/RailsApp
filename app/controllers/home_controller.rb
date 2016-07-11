class HomeController < ApplicationController
 before_action :authenticate_account!,only: :authentication
  def index
  end

  def authentication
  end
end
