class Admins::OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :user_block

  def index
    @path = Rails.application.routes.recognize_path(request.referer)

    if @path[:controller] == "admins/products" && [:action] == "top"
      @orders = Order.where("created_at = ?", Date.today).page(params[:page]).reverse_order
      # 管理者用のトップページから遷移したら当日分のオーダー一覧を表示する
    elsif @path[:controller] == "admins/users" && [:action] == "show"
      @orders = Order.where("user_id = ?", request_referer[:id]).page(params[:page]).reverse_order
      # 会員詳細から遷移したらユーザーのオーダー一覧を表示する
    else
      @orders = Order.page(params[:page]).reverse_order
      # その他(ヘッダ)から遷移したら全てのオーダーを表示する
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_products = @order.order_products
  end

  def update

  end

  private
  def user_block
    if user_signed_in?
      redirect_to root_path
    end
  end
end
