class Admins::ProductsController < ApplicationController

  def top
    @orders = Order.where("created_at = ?", Date.today).page(params[:page]).reverse_order
  end

  def index
    @products = Product.all

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
      redirect_to admins_product_path(@product), notice: "商品登録完了！"
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admins_product_path(@product), notice: "商品編集完了！"
    else
      render edit_admins_product_path
    end
  end

  private
  def product_params
  	params.require(:product).permit(:genre_id, :name, :image, :description, :price, :is_active)
  end

end
