class ProductsController < ApplicationController
  def index
  end

  def new
  end
  def create
    @product = Product.create(product_params)
  end

  private
    def product_params
    end
end
