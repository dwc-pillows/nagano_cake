class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :user_block

  def index
    @users = User.page(params[:page]).per(3)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admins_user_path(@user), notice: '会員情報が更新されました'
    else
      render edit_admins_user_path
    end
  end

  private
  def user_params
  	params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :zip_code, :address, :phone_number, :email, :is_active)
  end

  def user_block
    if user_signed_in?
      redirect_to root_path
    end
  end

end
