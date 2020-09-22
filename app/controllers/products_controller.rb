class ProductsController < ApplicationController
  def index
    @parents = Category.where(ancestry: nil)
  end

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
    # @user_id = @product.user_id
    # @user = User.find(@user_id)
    @user = @product.user
    @category_id = @product.category_id
    @category_parent = Category.find(@category_id)
    @category_child = Category.find(@category_id).children
    @category_grandchild = Category.find(@category_id).indirects
    # @brand_id = @product.brand_id
    # @brand = Brand.find(@brand_id)
    @brand = @product.brand
    @images = @product.product_images.drop(1)
    @parents = Category.where(ancestry: nil)
  end

  def edit
    @product = Product.find(params[:id])


  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to show_product_path, notice: '更新しました'
    else
      render :edit
    end
  end
  

  def create
    @category_parent = Category.where(ancestry: nil)
    @product = Product.new(product_params)         
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
      shipping_attributes: [:area, :fee, :handing_time, :shipping_type],
      brand_attributes: [:name]).merge(user_id: current_user.id)
    end


  end
  
