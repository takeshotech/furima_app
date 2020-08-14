Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :orders, only: :show
  resources :users, only: [:index, :edit, :update]
end
