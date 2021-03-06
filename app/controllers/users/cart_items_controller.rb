class Users::CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_block

  def index
    @cart_items = current_user.cart_items
    @latest_order = current_user.orders.order(created_at: :desc).take
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.user_id = current_user.id
    @cart_item.save
    redirect_to users_cart_items_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    @user = User.find(current_user.id)
    @cart_items = current_user.cart_items
    redirect_to users_cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    if cart_item.destroy
      flash[:notice] = "カート内の商品を削除しました。"
      redirect_to users_cart_items_path
    else
      @user = User.find(current_user.id)
      render "index"
    end
  end

  def destroy_all
    user = User.find(current_user.id)
    if user.cart_items.destroy_all
      flash[:notice] = "カート内の商品を全て削除しました。"
      redirect_to users_cart_items_path
    else
      @user = User.find(current_user.id)
      render "index"
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:user_id, :product_id, :amount)
  end

  def admin_block
    if admin_signed_in?
      redirect_to admins_path
    end
  end

end
