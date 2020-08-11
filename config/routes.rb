Rails.application.routes.draw do
  root 'items#index'
  resources :orders, only: :show
end
