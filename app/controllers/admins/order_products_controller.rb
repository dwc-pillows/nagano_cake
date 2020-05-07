class Admins::OrderProductsController < ApplicationController
  before_action :authenticate_admin!
  before_action :user_block

  def update
    
  end

  private
  def user_block
    if user_signed_in?
      redirect_to root_path
    end
  end
end
