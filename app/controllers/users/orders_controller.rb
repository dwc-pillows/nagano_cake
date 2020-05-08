class Users::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_block

# 新規注文作成ページ(GET)
  def new
    @order = current_user.orders.new
    @deliveries = current_user.deliveries
  end

# 新規注文作成アクション(POST)
  def create
		@order = current_user.orders.new(order_params)
    case params[:delivery_type]
    when "0"
      @order.zip_code = current_user.zip_code
      @order.address = current_user.address
      @order.name = current_user.last_name + current_user.first_name
    when "1"
      @delivery = current_user.deliveries.find(params[:Delivery][:chosen_id])
      @order.zip_code = @delivery.zip_code
      @order.address = @delivery.address
      @order.name = @delivery.name
    else
      @delivery = current_user.deliveries.new
    end

    @order.total_price = 0
    @order.save

    redirect_to users_confirmation_order_path(@order)
  end

# 注文確認画面(GET)
  def confirmation
    @order = Order.find(params[:id])
    @cart_items = current_user.cart_items
  end

# 注文確定アクション(POST)
  def confirm
    @order = Order.find(params[:id])
    if @order.save!
      # cart_items=>order_products
      current_user.cart_items.each do |cart_item|
        @order_products = OrderProduct.new(
          order_id: @order.id,
          product_id: cart_item.product_id,
          taxed_product_price: cart_item.product.taxed_price,
          amount: cart_item.amount)
        @order_products.save!
      end
      current_user.cart_items.destroy_all
    end
    redirect_to users_orders_thanks_path
  end

# サンクスページ(GET)
  def thanks
  end


# 注文履歴一覧ページ (GET)
  def index
    @orders = current_user.orders
  end

# 注文履歴詳細ページ(GET)
  def show
    
  end



  private
  def order_params
    params.require(:order).permit(:user_id, :pay_method, :zip_code, :address, :name)
  end

  private

  def admin_block
    if admin_signed_in?
      redirect_to admins_path
    end
  end

end
