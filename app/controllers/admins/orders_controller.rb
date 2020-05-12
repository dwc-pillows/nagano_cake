class Admins::OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :user_block

  def index
    path = Rails.application.routes.recognize_path(request.referer)

    if path[:controller] == "admins/products" && path[:action] == "top"
      @orders = Order.where("created_at = ?", Date.today).page(params[:page]).reverse_order.per(10)
      # 管理者用のトップページから遷移したら当日分のオーダー一覧を表示する
    elsif path[:controller] == "admins/users" && path[:action] == "show"
      @orders = Order.where("user_id = ?", path[:id]).page(params[:page]).reverse_order.per(10)
      # 会員詳細から遷移したらユーザーのオーダー一覧を表示する
    else
      @orders = Order.page(params[:page]).reverse_order.per(10)
      # その他(ヘッダ)から遷移したら全てのオーダーを表示する
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
