class Users::ProductsController < ApplicationController
  before_action :admin_block
  before_action :set_genre, only: [:top, :index, :show,:search]

  def top
    # オススメ商品を4つずつ表示する
    @products = active_products.where(is_active:true, recommend: true).page(params[:page]).reverse_order.per(4)
  end

  def index
    @products = active_products.page(params[:page])
    @product_all = active_products
    user_cart_items
    @title = "商品一覧"
  end

  def search
    genre = Genre.find(params[:id])
    @products = active_products.where(genre_id: genre).page(params[:page])
    @product_all = active_products.where(genre_id: genre)
    @title = genre.name + "一覧"
    user_cart_items
    render "index"
  end

  def show
    @product = Product.find(params[:id])
    # ログインしている場合のみカート編集アクションを行う
    if current_user.present?
      items = current_user.cart_items
      # CartItemモデルに対して親がUserとProductでそれぞれの親にアソシエーションはないのでこの記述
      # 中間モデルでもう少しシンプルにかけると思われる
      if items.find_by(product_id: @product.id).present?
        @cart_item = items.find_by(product_id: @product.id)
      else
        @cart_item = items.new(product_id: @product.id)
      end
    end
  end

  def active_products
    Product.joins(:genre).where(genres:{is_active:true})
  end

  def user_cart_items
    if current_user.present?
      @cart_items = current_user.cart_items
    end
  end

  private
  def set_genre
    @genres = Genre.where(is_active:true)
  end

  def admin_block
    if admin_signed_in?
      redirect_to admins_path
    end
  end

end
