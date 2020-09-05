class CategoriesController < ApplicationController
  def new
    @parents = Category.where(ancestry: nil)
    @children = Category.find(params[:parent_id]).children
    respond_to do |format|
      format.html
      format.json
    end
  end

  def parent
    @category = Category.find(params[:id])
    children = @category.children
    grandchildren = []
    # ancestryに親要素id・子要素idが入っている要素全て取得
    children.each do |child|
      grandchildren << Category.where(ancestry: "#{@category.id}/#{child.id}")
    end
    @products = []
    # grandchildrenは多重配列の為、each文を二回重ねることで親要素がもつ全ての孫要素のidをwhereメソッドに渡す
    grandchildren.each do |grandchild|
      grandchild.each do |id|
        @products += Product.where(category_id: id)
      end
    end
  end

  def child
    grandchildren = @category.children
    @products = []
    #子要素の孫要素という一つの配列の為、一度のeach文で孫要素のidを取得
    grandchildren.each do |grandchild|
      @products += Product.where(category_id: grandchild.id)
    end
  end
end
