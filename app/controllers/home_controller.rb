class HomeController < ApplicationController
  def index
    @images = ProductImage.order("created_at DESC").page(params[:page]).per(5)
    @products = Product.order("created_at DESC").page(params[:page]).per(5)
  end
end