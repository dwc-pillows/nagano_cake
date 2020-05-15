class Admins::OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :user_block

  def index
    case params[:order_sort]
    when "0"
      @orders_today_all = Order.where(created_at: Date.today.in_time_zone.all_day)
      @orders = @orders_today_all.order(created_at: :asc).page(params[:page]).reverse_order.per(10)
    when "1"
      @user = User.find(params[:user_id])
      @orders = @user.orders.order(created_at: :asc).page(params[:page]).reverse_order.per(10)
    else
      @orders = Order.all.order(created_at: :asc).page(params[:page]).reverse_order.per(10)
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_products = @order.order_products
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.order_status == 1
      @order.order_products.each do |order_product|
        order_product.update(production_status: 1)
      end
    end
    flash[:notice] = "ステータスが更新されました"
    redirect_to admins_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end

  def user_block
    if user_signed_in?
      redirect_to root_path
    end
  end
end
