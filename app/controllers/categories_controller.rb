class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  def index
    @parents = Category.where(ancestry: nil)
  end

  def show
    @products = @category.set_products
    @products = @products.order("created_at DESC").page(params[:page]).per(9)
    @parents = Category.where(ancestry: nil)
  end

  private
  def set_category
    @category = Category.find(params[:id])
    if @category.has_children?
      @category_links = @category.children
    else
      @category_links = @category.siblings
    end
  end
end