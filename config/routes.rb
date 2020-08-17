Rails.application.routes.draw do
  root 'products#index'
  resources :products, only: [:index, :new, :create]
  resources :orders, only: :show

end
