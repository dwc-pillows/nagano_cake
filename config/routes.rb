Rails.application.routes.draw do
 root 'users/products#top' 
 
  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admin/sign_in' => 'admins/sessions#new', as: :new_admin_session
    post 'admin/sign_in' => 'admins/sessions#create', as: :admin_session
    delete 'admin/sign_out' => 'admins/sessions#destroy', as: :destroy_admin_session
  end
  
  devise_for :users, skip: :all
  devise_scope :user do
    get 'users/sign_in' => 'users/sessions#new', as: :new_user_session
    post 'users/sign_in' => 'users/sessions#create', as: :user_session
    delete 'users/sign_out' => 'users/sessions#destroy', as: :destroy_user_session
    get 'users/sign_up' => 'users/registrations#new', as: :new_user_registration
    post 'users' => 'users/registrations#create', as: :user_registration
  end
  
  namespace :users do
    resources :users, only: [:show, :withdraw_confirm, :withdraw, :edit, :update]
    resources :products, only: [:top, :index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy, :destroy_all]
    resources :orders, only: [:new, :confirm, :create, :thanks, :index, :show]
    resources :deliveries, only: [:index, :create, :edit, :update, :destroy]
  end

  namespace :admins do
    resources :products, only: [:top, :index, :new, :show, :create, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit , :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_produts, only: [:update]
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
