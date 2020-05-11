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
      current_user.deliveries.create!(
        zip_code: @order.zip_code,
        address: @order.address,
        name: @order.name
      )
    end

    @order.save

    redirect_to users_confirmation_order_path(@order)
  end

# 注文確認画面(GET)
  def confirmation
    @order = Order.find(params[:id])
    @cart_items = current_user.cart_items
    @latest_order = current_user.orders.order(created_at: :desc).take
  end

# お届け先編集画面(GET)
  def edit
    @order = Order.find(params[:id])
    @deliveries = current_user.deliveries
  end

# お届け先情報更新(PATCH/PUT)
  def update
    @order = Order.find(params[:id])
    case params[:delivery_type]
    when "0"
      @order.update(
      zip_code: current_user.zip_code,
      address: current_user.address,
      name: current_user.last_name + current_user.first_name,
      pay_method: params[:order][:pay_method]
      )
      redirect_to users_confirmation_order_path(@order), notice: "お届け先情報が修正されました"
    when "1"
      @delivery = current_user.deliveries.find(params[:Delivery][:chosen_id])
      @order.update(
        zip_code: @delivery.zip_code,
        address: @delivery.address,
        name: @delivery.name,
        pay_method: params[:order][:pay_method]
      )
      redirect_to users_confirmation_order_path(@order), notice: "お届け先情報が修正されました"
    when "2"
      if @order.update(order_params)
        current_user.deliveries.create!(
          zip_code: params[:order][:zip_code],
          address: params[:order][:address],
          name: params[:order][:name]
        )
        redirect_to users_confirmation_order_path(@order), notice: "お届け先情報が修正されました"
      else
        flash[:notice] = "error:必要な情報が記載されていません。"
      end
    # お届け先のラジオボタンが選択されていない時
    else
      flash[:notice] = "error:お届け先が選択されていません。"
      @deliveries = current_user.deliveries
      render "edit"
    end
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
        @order.update(total_price: sum_price(@order))
      end
      current_user.cart_items.destroy_all
    end
    redirect_to users_thanks_path
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
    @order = Order.find(params[:id])
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    current_user.cart_items.destroy_all
    redirect_to root_path
  end

  private
  def order_params
    params.require(:order).permit(:user_id, :pay_method, :zip_code, :address, :name)
  end

# 注文の請求合計金額計算
  def sum_price(order)
    total = 0
    order.order_products.each do |order_product|
      total += order_product.subtotal
    end
    total + order.postage
  end

  def admin_block
    if admin_signed_in?
      redirect_to admins_path
    end
  end

end
