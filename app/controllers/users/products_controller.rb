class Users::ProductsController < ApplicationController
  before_action :admin_block

  def top

  end

  def index
    # currentuserのカート内の商品個数記載お願いします。
    @products = Product.all.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
    @cart_item = CartItem.new(product_id: @product.id)

    # ユーザーがログインしていない場合、itemsの内容を全商品とし、ログイン中はカートアイテムを対象にする
    if current_user.nil?
      items = CartItem.all
    else
      items = current_user.cart_items
    end
    # カートアイテム内の商品IDとitems内の商品IDに含まれていれば、商品詳細ページにエラーが出るようにする。
    if items.pluck(:product_id).include?(@cart_item.product_id)
      flash[:notice] = "商品はカートに追加済です"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def admin_block
    if admin_signed_in?
      redirect_to admins_path
    end
  end

end
