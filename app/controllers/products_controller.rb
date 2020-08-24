class ProductsController < ApplicationController
  def index
  end

  def new
    # データベースから親カテゴリーのみ抽出し、配列化
    @category_parent = Category.where(ancestry: nil)
  end
  def create
    @product = Product.create(product_params)
  end

  private
    def product_params
    end
end
