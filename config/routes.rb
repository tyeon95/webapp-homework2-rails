Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    resources :comments
  end
  get "users/check_signed_in"
  post "users/api_sign_in"
  delete "users/api_sign_out"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
