# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  before_action :admin_block
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # emailを参照してユーザの特定した後にユーザのis_activeカラムをパラメータとして持ってくる
  # 実際はauthentication_keysを変更した方が良さそうだが暫定でこのように実装する
  def configure_sign_in_params
    @user = User.find_by(email: params[:user][:email])
    if @user.is_active?
    else
      flash[:notice] = "あなたは退会済みユーザです。"
      redirect_to root_path
    end
  end

  private

  def admin_block
    if admin_signed_in?
      redirect_to admins_path
    end
  end

end
