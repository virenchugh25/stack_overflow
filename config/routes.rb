Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :questions
  resources :answers, only: [:create, :update, :destroy]
  resources :comments, only: [:create, :update, :destroy]
  resources :votes, only: [:create, :destroy]
  
  post '/login', to: 'sessions#login'
  delete '/logout', to: 'sessions#destroy'
end
