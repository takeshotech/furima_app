class ProductsController < ApplicationController
  before_action :category_parent_array, only: [:new, :create, :edit]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :show_all_instance, only: [:show, :edit, :destroy]
  
  
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

  def edit
    grandchild = @product.category
    child = grandchild.parent
    if @category_id == 46 or @category_id == 74 or @category_id == 134 or @category_id == 142 or @category_id == 147 or @category_id == 150 or @category_id == 158
    else
     @parent_array = []
     @parent_array << @product.category.parent.parent.name
     @parent_array << @product.category.parent.parent.id 
    end
     @category_children_arry = Category.where(ancestry: grandchild.ancestry)
     @grandchild_arry = []
     @grandchild_array << grandchild.name
     @grandchild_array << grandchild.id


  end

  def update
    if product_params[:images_attributes].nill?
      flash.now[:alert] = '更新できませんでした 【画像を１枚以上入れてください】'
      render :edit
    else
      exit_ids = []
      product_params[:images_attributes].each do |a,b|
        exit_ids << product_params[:images_attributes].dig(:"#{a}",:id).to_i
      end
      ids = Image.where(item_id: params[:id]).map{|image| image.id }
      delete__db = ids - exit_ids
      Image.where(id:delete__db).destroy_all
      @product.touch
      if @product.update(product_params)
        edirect_to  update_done_product_path
      else
        flash.now[:alert] = '更新できませんでした'
        render :edit
      end  
    end
  end
  def update_done
    @product_update = Product.order("update_at DESC").first
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
  
  private
    def product_params
      params.require(:product).permit(:name, :text, :condition, :price, :trading_status, :category_id, product_images_attributes: [:image_url, :product_id],
      shipping_attributes: [:id, :area, :fee, :handing_time, :shipping_type],
      brand_attributes: [:id, :name]).merge(user_id: current_user.id)
    end
    def product_params
      params.require(:product).permit(:name, :product_explanation, :category_id, :product_status, :auction_status, :delivery_fee, :shipping_origin, :exhibition_price,:brand_name, :days_until_shipping, images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
    end
    def set_item
      #@product = Product.find(params[:id])
    end
    def category_parent_array
      @category_parent_array = Category.where(ancestry: nil)
    end

    def show_all_instance
      @user = User.find(@product.user_id)
      @image = Image.where(product_id: params[:id])
      @image_first =Image.where(product_id: params[:id])
      @category_id = @product.category_id
      @category_parent = Category.find(@category_id).parent.parent 
      @category_child = Category.find(@category_id).parent
      @category_grandchild = Category.find(@category_id)
    end
  end
  
