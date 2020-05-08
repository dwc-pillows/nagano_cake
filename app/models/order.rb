class Order < ApplicationRecord
  has_many :order_products, dependent: :destroy
  belongs_to :user

  enum paymethod: {"クレジットカード": 0, "銀行振り込み": 1}
  def total_price
    user.cart_items_sum + postage
  end
  def confirmed
  end
end
