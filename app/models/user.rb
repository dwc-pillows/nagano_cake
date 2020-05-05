class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :deliveries, dependent: :destroy

  # カート商品合計金額（小計の合計）
  def cart_items_sum
    total = 0
    cart_items.each do |cart_item|
      total += cart_item.subtotal
    end
    total
  end

  # カート商品合計個数（各商品個数の合計）
  def cart_items_count
    count = 0
    cart_items.each do |cart_item|
      count += cart_item.amount
    end
    count
  end

end
