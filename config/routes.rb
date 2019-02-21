Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "welcome#index"
  resources :items, only: [:index, :show]
  resources :users, only: [:new, :create]
  # get '/profile', to 'user#show', as: user_path
  resources :merchants, only: [:index]

  resources :cart, only: [:index, :create, :destroy]

  delete '/cart/item/:id', to: 'cart#delete_item', as: 'delete_cart_item'
  put '/cart/item/:id', to: 'cart#update_item_quantity', as: 'update_cart_item'
  # put '/cart/item/:id', to: 'cart#remove_item_quantity', as: 'remove_cart_item'
  # resources :carts, only: [:index]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/profile', to: 'users#profile', as: 'profile'
  put '/profile', to: 'users#update'
  get '/profile/orders', to: 'users/orders#index', as: 'profile_orders'
  post '/profile/orders', to: 'users/orders#create', as: 'new_profile_order'
  post '/profile/orders/:id/cancel', to: 'users/orders#cancel', as: 'profile_cancel_order'
  get '/profile/orders/:id', to: 'users/orders#show', as: 'profile_order'
  get '/profile/edit', to: 'users#edit', as: 'edit_profile'

  get '/dashboard', to: 'merchants#dashboard', as: 'dashboard'
  get '/dashboard/orders/:id', to: 'merchants/orders#show', as: 'dashboard_orders'

  patch '/dashboard/items/:id/enable', to: 'merchants/items#enable', as: 'merchant_enable_item'

  patch '/dashboard/items/:id/disable', to: 'merchants/items#disable', as: 'merchant_disable_item'

  put '/dashboard/orders/:id/edit', to: 'merchants/orders#edit', as: 'dashboard_edit_order'
  get '/dashboard/items', to: 'merchants/items#index', as: 'dashboard_items'
  get '/dashboard/items/new', to: 'merchants/items#new', as: 'dashboard_new_item'
  post '/dashboard/items/new', to: 'merchants/items#create', as: 'dashboard_create_new_item'
  get '/dashboard/items/:id/edit', to: 'merchants/items#edit', as: 'dashboard_edit_item'
  patch '/dashboard/items/:id/edit', to: 'merchants/items#update', as: 'dashboard_update_item'
  delete '/dashboard/items/:id/delete', to: 'merchants/items#destroy', as: 'dashboard_delete_item'
  post '/login', to: 'sessions#create'

  namespace :admin do
    get '/users', to: 'users#index', as: 'users'
    get '/dashboard', to: 'users#dashboard', as: 'dashboard'
    get '/users/:id', to: 'users#show', as: 'user'
    get '/merchants/:id', to: 'merchants#show', as: 'merchant'
    get '/merchant_downgrade', to: 'merchants#downgrade', as: 'merchant_downgrade'
    get '/user_upgrade', to: 'users#upgrade', as: 'user_upgrade'
    get '/merchants/:id/orders/:order_id', to: 'merchants/orders#show', as: 'merchant_order'
    put '/merchant/:id/orders/:order_id/edit', to: 'merchants/orders#edit', as: 'merchant_edit_order'
    get '/merchant/:id/items', to: 'merchants/items#index', as: 'merchant_items'
    get '/merchant/:id/items/new', to: 'merchants/items#new', as: 'merchant_new_item'
    post '/merchant/:id/items/new', to: 'merchants/items#create', as: 'merchant_create_new_item'
    get '/merchant/:id/items/:item_id/edit', to: 'merchants/items#edit', as: 'merchant_edit_item'
    patch '/merchant/:id/items/:item_id/edit', to: 'merchants/items#update', as: 'merchant_update_item'

    patch '/merchant/:id/items/:item_id/enable', to: 'merchants/items#enable', as: 'merchant_enable_item'

    patch '/merchant/:id/items/:item_id/disable', to: 'merchants/items#disable', as: 'merchant_disable_item'

    delete '/merchant/:id/items/:item_id/delete', to: 'merchants/items#destroy', as: 'merchant_delete_item'
    get '/users/:id/orders', to:'users/orders#index', as: 'user_orders'
    patch '/users/:id/enable', to:'users#enable', as: 'enable_user'
    patch '/users/:id/disable', to:'users#disable', as: 'disable_user'
    patch '/merchants/:id/enable', to:'merchants#enable', as: 'enable_merchant'
    patch '/merchants/:id/disable', to:'merchants#disable', as: 'disable_merchant'
    get '/orders/:id', to: 'orders#show', as: 'order'
    post '/orders/:id/cancel', to: 'orders#cancel', as: 'cancel_order'
  end
end
