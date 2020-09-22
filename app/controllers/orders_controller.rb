class OrdersController < ApplicationController
  require "payjp"
  before_action :find_product, only:[:create, :show]

  def create
    @parents = Category.where(ancestry: nil)
    # 購入テーブル登録ずみ商品は２重で購入されないようにする
    # (２重で決済されることを防ぐ)
    if @product.order.present?
      redirect_to product_path(@product.id), alert: "売り切れています。"
    else
      # 同時に2人が同時に購入し、二重で購入処理がされることを防ぐための記述
      @product.with_lock do
        
        if current_user.credit_card.present?
          # ログインユーザーがクレジットカード登録済みの場合の処理
          # ログインユーザーのクレジットカード情報を引っ張ってきます。
          @card = CreditCard.find_by(user_id: current_user.id)
          Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
          #登録したカードでの、クレジットカード決済処理
          charge = Payjp::Charge.create(
          # 商品(product)の値段を引っ張ってきて決済金額(amount)に入れる
          amount: @product.price,
          customer: Payjp::Customer.retrieve(@card.customer_id),
          currency: 'jpy'
          )
        else
          Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
          # ログインユーザーがクレジットカード登録されていない場合(Checkout機能による処理を行います)
          # APIの「Checkout」ライブラリによる決済処理の記述
          Payjp::Charge.create(
          amount: @product.price,
          card: params['payjp-token'], # フォームを送信すると作成・送信されてくるトークン
          currency: 'jpy'
          )
        end
      #購入テーブルに登録処理
      @order = Order.create(user_id: current_user.id, product_id: params[:id])
      end
    end
  end  

  def show
    if user_signed_in?
      current_user
      # クレジットカードが登録されているか確認
      if current_user.credit_card.present?
        Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
        # ログインユーザーのクレジットカード情報を引っ張ってきます。
        @card = CreditCard.find_by(user_id: current_user.id)
        # (以下は以前のcredit_cardsコントローラーのshowアクションとほぼ一緒です)
        # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
        customer = Payjp::Customer.retrieve(@card.customer_id)
        # カスタマー情報からカードの情報を引き出す
        @customer_card = customer.cards.retrieve(@card.card_id)

        ##カードのアイコン表示のための定義づけ
        @card_brand = @customer_card.brand
        case @card_brand
        when "Visa"
          # 例えば、Pay.jpからとってきたカード情報の、ブランドが"Visa"だった場合は返り値として
          # (画像として登録されている)Visa.pngを返す
          @card_src = "visa.png"
        when "JCB"
          @card_src = "jcb.png"
        when "MasterCard"
          @card_src = "master.png"
        when "American Express"
          @card_src = "amex.png"
        when "Diners Club"
          @card_src = "diners.png"
        when "Discover"
          @card_src = "discover.png"
        end
        # viewの記述を簡略化
        ## 有効期限'月'を定義
        @exp_month = @customer_card.exp_month.to_s
        ## 有効期限'年'を定義
        @exp_year = @customer_card.exp_year.to_s.slice(2,3)
      else
      end
    else
      # ログインしていなければ、商品の購入ができずに、ログイン画面に移動します。
      redirect_to user_session_path, alert: "ログインしてください"
    end
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
