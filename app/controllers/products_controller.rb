class ProductsController < ApplicationController
  def index
  end

  def new
    # データベースから親カテゴリーのみ抽出し、配列化
    @category_parent = Category.where(ancestry: nil)
  end

  # 親カテゴリーが選択された後に動くアクション
  def get_category_children
    @category_children = Category.find(params[:parent_id]).children
  end
  def create
    @product = Product.create(product_params)
  end

  private
    def product_params
    end
end
