class Admins::ProductsController < ApplicationController

  def top

  end

  def index

  end

  def show

  end
  
  def new
    @product = Product.new
  end

  def create
    @product =Product.new(product_params)
    if @product.save
      redirect_to admins_product_path(@product), notice: "商品登録完了！"
    end
  end

  def edit

  end

  def update
    
  end

  private
  def product_params
  	params.require(:product).permit(:genre_id, :name, :image_id, :description, :price, :is_active)
  end

end
