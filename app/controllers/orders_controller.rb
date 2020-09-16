class OrdersController < ApplicationController
  require "payjp"

  def show
  end


  def pay
    # 後ほどbefore_actionにまとめる
    @product = Product.find(params[:product_id])
    @images = @product.images.all

    # 購入テーブル登録ずみ商品は２重で購入されないようにする
    # (２重で決済されることを防ぐ)
    if @product.purchase.present?
      redirect_to product_path(@product.id), alert: "売り切れています。"
    else
      # 同時に2人が同時に購入し、二重で購入処理がされることを防ぐための記述
      @product.with_lock do
        if current_user.credit_card.present?
          @card = CreditCard.find_by(user_id: current_user.id)
          Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
          charge = Payjp::Charge.create(
          amount: @product.price,
          customer: Payjp::Customer.retrieve(@card.customer_id),
          currency: 'jpy'
          )
        else
          Payjp::Charge.create(
          amount: @product.price,
          card: params['payjp-token'], 
          currency: 'jpy'
          )
        end
      #購入テーブルに登録処理
      @oreder = Order.create(buyer_id: current_user.id, product_id: params[:product_id])
      end
    end
  end
end
