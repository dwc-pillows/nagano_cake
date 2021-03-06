class Users::UsersController < ApplicationController

  before_action :set_user, except: [:withdraw, :withdraw_confirm]
  before_action :authenticate_user!
  before_action :admin_block

  def show
    # ログインしていないか、ユーザーIDが現在のIDと異なっている場合はメッセージ付でトップページへ返す
    unless current_user.nil? || current_user.id == @user.id
      flash[:notice] = "アクセス権がありません"
      redirect_to root_path
    end
  end

  def withdraw_confirm
  end

  def withdraw
    user = User.find(current_user.id)
    user.is_active = false
    user.save
    flash[:notice] = "ご利用ありがとうございました。"
    redirect_to root_path
  end

  def edit
    unless current_user.nil? || current_user.id == @user.id
      flash[:notice] = "アクセス権がありません"
      redirect_to root_path
    end
  end

  def update
    if @user.update(user_params)
      redirect_to users_user_path(@user)
    else
      flash[:notice] = "入力内容に誤りがあります"
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :zip_code, :address, :phone_number, :is_active)
  end

  def admin_block
    if admin_signed_in?
      redirect_to admins_path
    end
  end

end
