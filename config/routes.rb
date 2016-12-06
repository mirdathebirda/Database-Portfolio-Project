Rails.application.routes.draw do
  root 'home#index'

#mapping of url to controller
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  get '/users/:user_id/blogs' => 'blogs#index'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  resources :blogs do
    resources :posts do
      #except: :new, :edit -- dont make routes for these commands
      resources :comments, only: [:create, :update, :destroy]
      resources :categories, only: [:create, :destroy, :search]

      post '/star' => 'stars#star'
      delete '/star' => 'stars#unstar'
    end
  end
end
