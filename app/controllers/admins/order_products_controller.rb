class Admins::OrderProductsController < ApplicationController
  before_action :authenticate_admin!
  before_action :user_block

  def update
    @order_products = OrderProduct.find(params[:id])
    @order_products.update(order_products_params)
    flash[:notice] = "制作ステータスが変更されました"
    redirect_back(fallback_location: root_path)
  end

  private

  def order_products_params
    params.require(:order_product).permit(:production_status)
  end

  def user_block
    if user_signed_in?
      redirect_to root_path
    end
  end
end
