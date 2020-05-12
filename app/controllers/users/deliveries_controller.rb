class Users::DeliveriesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_block

  def index
    @delivery = Delivery.new
    @deliveries = current_user.deliveries
  end

  def create
    @delivery = current_user.deliveries.new(delivery_params)
    @delivery.save
    redirect_to users_deliveries_path , notice: "配送先を新規登録しました"
  end

  def edit
    @delivery = current_user.deliveries.find(params[:id])
  end

  def update
    @delivery = current_user.deliveries.find(params[:id])
    @delivery.update(delivery_params)
    redirect_to users_deliveries_path , notice: "配送先情報を更新しました"
  end

  def destroy
    @delivery = current_user.deliveries.find(params[:id])
  	@delivery.destroy
  	redirect_to users_deliveries_path , notice: "配送先を削除しました"
  end

  def destroy_all

  end

  private
  def delivery_params
      params.require(:delivery).permit(:user_id ,:zip_code, :address, :name)
    end

  def admin_block
    if admin_signed_in?
      redirect_to admins_path
    end
  end

end
