class ProductsController < ApplicationController
  def index
  end
  
  def new
    @product = Product.new
    @product.build_brand
    @product.product_images.build
    @product.build_shipping
  end

  def create
    @product = Product.create(product_params)
  end
  
  private
    def product_params
      params.require(:product).permit(:name, :text, :condition, :price, :trading_status, :category_id, product_images_attributes: [:image_url, :product_id],
      shipping_attributes: [:id, :area, :fee, :handing_time, :product_id],
      brand_attributes: [:id, :name])
    end
  end
  