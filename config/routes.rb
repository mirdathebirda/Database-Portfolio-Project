Rails.application.routes.draw do
  root 'home#index'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  get '/users/:user_id/blogs' => 'blogs#index'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  resources :blogs
  
end
