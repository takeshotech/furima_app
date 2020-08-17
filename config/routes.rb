Rails.application.routes.draw do
  root 'items#index'
  resources :products, only: [:index, :new, :create]
  resources :orders, only: :show

end
