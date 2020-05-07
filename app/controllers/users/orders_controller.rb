class Users::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_block


  def new

  end

  def index

  end

  def show

  end

  def confirm

  end

  def create

  end

  def thanks

  end

  private

  def admin_block
    if admin_signed_in?
      redirect_to admins_path
    end
  end

end
