Rails.application.routes.draw do
  resources :users, only: [ :new, :create ]
  resource :session
  resources :passwords, param: :token

  resources :tweets, only: [ :index, :create, :destroy ] do
    resources :likes, only: [ :create, :destroy ]
    resources :comments, only: [ :create, :index ]
  end
  root "tweets#index"
end
