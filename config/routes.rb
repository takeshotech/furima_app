Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :edit, :update]
  root 'products#index'
  resources :products, only: [:index, :new, :create]
  resources :orders, only: :show

end
