Rails.application.routes.draw do
  root 'users/products#top'

  devise_for :admins, controllers: {
    sessions: "admins/sessions",
    passwords: "admins/passwords",
  }
  devise_for :users, controllers: {
    sessions: "users/sessions",
    passwords: "users/passwords",
    registrations: "users/registrations"
  }

  namespace :users do
    resources :users, only: [:show, :edit, :update]
    get "/users", to: "users#withdraw_confirm", as: "withdraw_confirm"
    patch "/users", to: "users#withdraw", as: "withdraw"
    resources :deliveries, only: [:index, :create, :edit, :update, :destroy]
    resources :products, only: [:index, :show]
    get "search/:id", to: "products#search", as:"products_search"
    resources :cart_items, only: [:index, :create, :update, :destroy]
    delete '/cart_items', to: 'cart_items#destroy_all', as: 'cart_items_destroy_all'
    resources :orders
    # 注文確認画面
    get '/orders/:id/confirm', to: 'orders#confirmation',as: 'confirmation_order'
    # 注文確定アクション
    post '/orders/:id/confirm', to: 'orders#confirm', as: 'confirm_order'
    get '/thanks', to: 'orders#thanks'
  end

  namespace :admins do
    resources :products, only: [:index, :new, :show, :create, :edit, :update]
    get '', to: 'products#top'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit , :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_products, only: [:update]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
