Rails.application.routes.draw do
  root 'products#index'
  resources :products, only: [:index, :new, :create, :show] do
    collection do
      get 'get_category_children', to: 'products#get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', to: 'products#get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  resources :categories, only: [:index, :new] do
    member do
      get 'parent'
      get 'child'
      get 'grandchild'
    end
  end
  resources :orders, only: :show
end