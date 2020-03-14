Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get :root, to: 'welcome#index'

  # resources :merchants do
  #   resources :items, only: [:index]
  # end
  get '/merchants/:merchant_id/items', to: 'items#index' #namespace
  get '/merchants', to: 'merchants#index'
  post '/merchants', to: 'merchants#create'
  get '/merchants/new', to: 'merchants#new'
  get '/merchants/:id/edit', to: 'merchants#edit'
  get '/merchants/:id', to: 'merchants#show'
  patch '/merchants/:id', to: 'merchants#update'
  delete '/merchants/:id', to: 'merchants#destroy'
  
  
  # resources :items, only: [:index, :show] do
  #   resources :reviews, only: [:new, :create]
  # end

  post '/items/:item_id/reviews', to: 'reviews#create'
  get '/items/:item_id/reviews/new', to: 'reviews#new'

  get '/items', to: 'items#index'
  get '/items/:id', to: 'items#show'

  get '/reviews/:id/edit', to: 'reviews#edit'
  patch '/reviews/:id/', to: 'reviews#update'
  delete '/reviews/:id/', to: 'reviews#destroy'

  get '/items', to: 'merchant/items#index'
  get '/items/new', to: 'merchant/items#new'
  post '/items', to: 'merchant/items#create'
  get '/items/:id/edit', to: 'merchant/items#edit'
  patch '/items/:id', to: 'merchant/items#update'
  delete '/items/:id', to: 'merchant/items#destroy'

  # resources :reviews, only: [:edit, :update, :destroy]

  get '/cart', to: 'cart#show'
  post '/cart/:item_id', to: 'cart#add_item'
  delete '/cart', to: 'cart#empty'
  patch '/cart/:change/:item_id', to: 'cart#update_quantity'
  delete '/cart/:item_id', to: 'cart#remove_item'

  get '/registration', to: 'users#new', as: :registration
  resources :users, only: [:create, :update]
  patch '/user/:id', to: 'users#update'
  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'
  get '/profile/edit_password', to: 'users#edit_password'
  post '/orders', to: 'user/orders#create'
  get '/profile/orders', to: 'user/orders#index'
  get '/profile/orders/:id', to: 'user/orders#show'
  delete '/profile/orders/:id', to: 'user/orders#cancel'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#login'
  get '/logout', to: 'sessions#logout'

  namespace :merchant do
    get '/', to: 'dashboard#index', as: :dashboard
    get '/discounts', to: 'discounts#index'
    get '/discounts/new', to: 'discounts#new'
    get '/orders/:id', to: 'orders#show'
    post '/items/:item_id/discounts', to: 'discounts#create'
    get '/items/:item_id/discounts/new', to: 'discounts#new'
    get '/items/:item_id/discounts/:id/edit', to: 'discounts#edit'
    patch '/items/:item_id/discounts/:id', to: 'discounts#update'
    get '/items/:item_id/discounts/:id', to: 'discounts#update'
    delete '/items/:item_id/discounts/:id', to: 'discounts#destroy'
    
    get '/items', to: 'items#index'
    post '/items', to: 'items#create'
    get '/items/new', to: 'items#new'
    get '/items/:id/edit', to: 'items#edit'
    patch '/items/:id', to: 'items#update'
    delete '/items/:id', to: 'items#destroy'

    # resources :discounts, only: [:index, :new]
    # resources :orders, only: :show
    # resources :items, only: [:index, :new, :create, :edit, :update, :destroy] do
    #   resources :discounts, only: [:new, :create, :edit, :update, :destroy] 
    # end
    put '/items/:id/change_status', to: 'items#change_status'
    get '/orders/:id/fulfill/:order_item_id', to: 'orders#fulfill'
    delete '/items/:id/change_status', to: 'items#change_status'
  end

  namespace :admin do
    get '/', to: 'dashboard#index', as: :dashboard
    get '/merchants/:id', to: 'merchants#show'
    patch '/merchants/:id', to: 'merchants#update'
    
    get '/users', to: 'users#index'
    get '/users/:id', to: 'users#show'

    # resources :merchants, only: [:show, :update]
    # resources :users, only: [:index, :show]
    patch '/orders/:id/ship', to: 'orders#ship'
  end


#after 
  # merchants


  # namespace :merchant do
  #   get '/', to: 'dashboard#index', as: :dashboard
  #     get '/orders', to: 'merchant/orders#show'

  #     get '/items', to: 'merchant/items#index'
  #     get '/items/new', to: 'merchant/items#new'
  #     post '/items', to: 'merchant/items#create'
  #     get '/items/:id/edit', to: 'merchant/items#edit'
  #     patch '/items/:id', to: 'merchant/items#update'
  #     delete '/items/:id', to: 'merchant/items#destroy'
     
  #     get '/discounts', to: 'merchant/discounts#index'
  #     get '/discounts/new', to: 'merchant/discounts#new'

  #     # get '/items/:id/discounts/new', to 

  # #     resources :discounts, only: [:new, :create, :edit, :update, :destroy] 
  # #   put '/items/:id/change_status', to: 'items#change_status'
  # #   get '/orders/:id/fulfill/:order_item_id', to: 'orders#fulfill'
  # end
end
