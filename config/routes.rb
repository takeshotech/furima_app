Rails.application.routes.draw do
  root 'products#index'
  resources :products, only: [:index, :new, :create] do
      resources :product_images, only: [:new, :create]
  end
  resources :brands, only: [:new, :create]
  resources :orders, only: :show

end
