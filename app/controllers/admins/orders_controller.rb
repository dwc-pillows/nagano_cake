class Admins::OrdersController < ApplicationController

  def index
    @path = Rails.application.routes.routes.recognize_path(request.referer)

    if @path[:controller] == "admins" && @path[:action] == "top"
      @orders = Order.where("created_at = ?", Date.today).page(params[:page]).reverse_order
      # 管理者用のトップページから遷移したら当日分のオーダー一覧を表示する
    elsif @path[:controller] == "admins/users" && @path[:action] == "show"
      @orders = Order.where("user_id = ?", request_referer[:id]).page(params[:page]).reverse_order
      # 会員詳細から遷移したらユーザーのオーダー一覧を表示する
    else
      @orders = Order.page(params[:page]).reverse_order
      # その他(ヘッダ)から遷移したら全てのオーダーを表示する
    end
  end

  def show

  end

  def update

  end
end
