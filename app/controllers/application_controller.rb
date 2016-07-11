class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :authenticate_account! #認証済みかを確認
end
