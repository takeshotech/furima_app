Rails.application.routes.draw do
  root 'products#index'
  resources :products, only: [:index, :new, :create] do
      resources :product_images, only: [:new, :create]
      resources :shippings, only: [:new, :create]
      resources :brands, only: [:new, :create]
  end
  resources :orders, only: :show

end