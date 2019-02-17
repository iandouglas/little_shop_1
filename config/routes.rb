Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "welcome#index"
  resources :items, only: [:index, :show]
  resources :users, only: [:new, :create]
  # get '/profile', to 'user#show', as: user_path
  resources :merchants, only: [:index]

  resources :cart, only: [:index, :create, :destroy]

  delete '/cart/item/:id', to: 'cart#delete_item', as: 'delete_cart_item'
  put '/cart/item/:id', to: 'cart#add_item', as: 'add_cart_item'
  # resources :carts, only: [:index]
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  get '/profile', to: 'users#profile', as: 'profile'
  put '/profile', to: 'users#update'
  get '/profile/orders', to: 'users/orders#index', as: 'profile_orders'

  get '/profile/edit', to: 'users#edit', as: 'edit_profile'

  get '/dashboard', to: 'users#dashboard', as: 'dashboard'
  post '/login', to: 'sessions#create'

  namespace :admin do
    get '/users', to: 'users#index', as: 'users'
    get '/dashboard', to: 'users#dashboard', as: 'dashboard'
  end
end
