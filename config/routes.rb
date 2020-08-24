Rails.application.routes.draw do
  root 'products#index'
  resources :products, only: [:index, :new, :create, :show]
  resources :orders, only: :show
  resources :products do
    collection do
      get 'get_category_children', to: 'products#get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', to: 'products#get_category_grandchildren', defaults: { format: 'json' }
    end
  end
end
