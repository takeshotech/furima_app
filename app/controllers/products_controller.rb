class ProductsController < ApplicationController
 
  
  def new
    @product = Product.new
    @product.build_brand
    @product.product_images.new
    @product.build_shipping
    # データベースから親カテゴリーのみ抽出し、配列化
    @category_parent = Category.where(ancestry: nil)
  end

  def show
    @product = Product.find(params[:id])
    @category_id = @product.category_id
    @category_parent = Category.find(@category_id)
    @category_child = Category.find(@category_id).children
    @category_grandchild = Category.find(@category_id).indirects
  end

  # 親カテゴリーが選択された後に動くアクション
  def get_category_children
    @category_children = Category.find(params[:parent_id]).children
  end

  # 子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end

  def create
    @category_parent = Category.where(ancestry: nil)
    @product = Product.create(product_params)
    if @product.save
      flash[:alert] = '出品が完了しました'
      redirect_to new_product_path 
      
    else
      flash[:alert] = '出品に失敗しました'
      @product.product_images.new
      render :new
    end  
  end

    def destroy
      product = Product.find(params[:id])
      if product.user_id == product.id
        product.destroy #destroyメソッドを使用し対象の商品を削除する。
      end
    end
  
  private
    def product_params
      params.require(:product).permit(:name, :text, :condition, :price, :trading_status, :category_id, product_images_attributes: [:image_url, :product_id],
      shipping_attributes: [:id, :area, :fee, :handing_time, :shipping_type],
      brand_attributes: [:id, :name]).merge(user_id: current_user.id)
    end


  end
  
