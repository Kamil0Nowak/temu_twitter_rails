Rails.application.routes.draw do
  resources :users, only: [ :new, :create ]
  resource :session
  resources :passwords, param: :token

  resources :tweets, only: [ :index, :create ]
  root "tweets#index"
end
