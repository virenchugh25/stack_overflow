Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  concern :commentable do 
    resources :comments, shallow: true
  end
  resources :users do 
    resources :questions, shallow: true, concerns: [:commentable] do 
      resources :answers, shallow: true, concerns: [:commentable]
    end
  end
  resources :votes, only: [:create, :destroy]
  
  post '/login', to: 'sessions#login'
  delete '/logout', to: 'sessions#destroy'
end
