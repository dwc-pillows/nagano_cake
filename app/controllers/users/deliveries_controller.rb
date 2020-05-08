class Users::DeliveriesController < ApplicationController

  def index
    @delivery = Delivery.new
    @deliveries = Delivery.all
  end

  def create
    @delivery = current_user.deliveries.new(delivery_params)
    @delivery.save
    redirect_to users_deliveries_path , notice: "配送先を新規登録しました！"
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def update
    @delivery = Delivery.find(params[:id])
    @delivery.update(delivery_params)
    redirect_to users_deliveries_path , notice: "配送先を更新しました！"
  end

  def destroy
    @delivery = Delivery.find(params[:id])
  	@delivery.destroy
  	redirect_to users_deliveries_path , notice: "配送先を削除しました！"
  end

  def destroy_all
    
  end

  private
  def delivery_params
      params.require(:delivery).permit(:user_id ,:zip_code, :address, :name)
  end
  
end
