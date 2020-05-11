class Admins::OrderProductsController < ApplicationController
  before_action :authenticate_admin!
  before_action :user_block

  def update
    # 一つなので単数系に修正
    @order_product = OrderProduct.find(params[:id])
    @order_product.update(order_products_params)
    @order = @order_product.order
    # .any?でも代用可
    if @order.order_products.where(production_status: 2).present?
      @order.update(order_status: 2)
    end
    if @order.order_products.all? {
      |order_product| order_product.production_status == 3}
      @order.update(order_status: 3)
    end
    flash[:notice] = "ステータスが変更されました"
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
