Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "welcome#index"
  resources :items, only: [:index]
  resources :users, only: [:new, :create, :show]
  # get '/profile', to 'user#show', as: user_path
  resources :merchants, only: [:index]

  # resources :carts, only: [:index]
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  get '/profile', to: 'users#show', as: 'profile'
  get '/profile/orders', to: 'users/orders#index', as: 'profile_orders'

end
