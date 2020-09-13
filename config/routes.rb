Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :edit, :update, :show]
  root 'home#index'
  resources :products, only: [:index, :new, :create, :show] do
    collection do
      get 'get_category_children', to: 'products#get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', to: 'products#get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  resources :categories, only: [:index, :new, :show]
  resources :orders, only: :show
  resources :credit_cards, only: [:new, :create, :show, :destroy] 
end
