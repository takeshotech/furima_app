class ProductsController < ApplicationController
  def index
  end
  
  def new
    @product = Product.new
    @product.build_brand
    @product.product_images.build
  end
  def create
    @product = Product.create(product_params)
  end
  
  private
    def product_params
      params.require(:product).permit(:name, :text, :condition, :price, :trading_status, images: [],
      shipping_attributes: [:id, :area, :fee, :handing_time],
      brand_attributes: [:id, :name]).merge(user_id: current_user.id)
    end
  end
  