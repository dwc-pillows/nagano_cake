class Order < ApplicationRecord
  has_many :order_products, dependent: :destroy
  belongs_to :user

  enum paymethod: {"クレジットカード": 0, "銀行振り込み": 1}
  def total_price
    total = 0
    order_products.each do |order_product|
      total += order_product.taxed_product_price * order_product.amount
    end
    total + postage
  end
end
