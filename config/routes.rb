Rails.application.routes.draw do
  get 'rooms/show'
  root to: "home#index"
  # get 'home/index'
  get 'home/authentication'
  devise_for :accounts
#   devise_scope :account do
#     get '/accounts/sign_out' => 'devise/sessions#destroy'
# 　end
  resources :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
