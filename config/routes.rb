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
    resources :users, only: [:show, :withdraw_confirm, :withdraw, :edit, :update]
    resources :products, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    delete '/cart_items/destroy_all', to: 'cart_items#destroy_all'
    resources :orders, only: [:new, :create, :index, :show]
    get '/orders/:id/confirm', to: 'orders#confirm'
    get '/orders/thanks', to: 'orders#thanks'
    resources :deliveries, only: [:index, :create, :edit, :update, :destroy]
  end

  namespace :admins do
    resources :products, only: [:index, :new, :show, :create, :edit, :update]
    get '', to: 'products#top'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit , :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_produts, only: [:update]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
