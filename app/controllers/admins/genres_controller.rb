class Admins::GenresController < ApplicationController
  before_action :authenticate_admin!
  before_action :user_block

  def index
    @genre = Genre.new
    @genres = Genre.all

  end

  def create
    genre = Genre.new(genre_params)
    if genre.save
      redirect_to admins_genres_path, notice: "ジャンルが追加されました"
      #保存された場合の移動先を指定。
    else
      @genre = Genre.new(genre_params)
      @genres = Genre.all
      flash[:notice] = "error：ジャンル名が入力されていません"
      render "index"
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    genre = Genre.find(params[:id])
    if genre.update(genre_params)
      redirect_to admins_genres_path, notice: "ジャンル情報が更新されました"
    else
      @genre = Genre.find(params[:id])
      flash[:notice] = "error：ジャンル名が入力されていません"
      render "edit"
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name, :is_active)
  end

  def user_block
    if user_signed_in?
      redirect_to root_path
    end
  end

end
