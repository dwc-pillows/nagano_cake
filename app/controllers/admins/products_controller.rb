class Admins::ProductsController < ApplicationController
  before_action :authenticate_admin!
  before_action :user_block

  def top
    @orders = Order.where(created_at: Date.today.in_time_zone.all_day)
  end

  def index
    @products = Product.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])

  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admins_product_path(@product), notice: "商品が新規登録されました"
    else
      render "new"
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admins_product_path(@product), notice: "商品情報が更新されました"
    else
      render "edit"
    end
  end

  private
  def product_params
  	params.require(:product).permit(:genre_id, :name, :image, :description, :price, :is_active, :recommend)
  end

  def user_block
    if user_signed_in?
      redirect_to root_path
    end
  end

end
