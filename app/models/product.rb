class Product < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_products, dependent: :destroy

  attachment :image

  # 税込単価
  def taxed_price
    (price * 1.1).round
  end
end
