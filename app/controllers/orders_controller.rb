class OrdersController < ApplicationController
  def create
    @orders = Order.new
  end  

  def show
  end
end
