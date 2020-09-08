Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :edit, :update, :show]
  root 'home#index'
  resources :products, only: [:index, :new, :create, :show] do
    resources :product_images, only: [:new, :create]
    resources :shippings, only: [:new, :create]
    resources :brands, only: [:new, :create]
    collection do
      get 'get_category_children', to: 'products#get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', to: 'products#get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  resources :orders, only: :show
  resources :credit_cards, only: [:new, :create, :show, :destroy] 
end
  