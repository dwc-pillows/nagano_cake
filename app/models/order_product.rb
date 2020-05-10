class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  enum production_status: {
    "着手不可": 0,
    "製作待ち": 1,
    "制作中": 2,
    "製作完了": 3
  }

  def taxed_product_price
    product.taxed_price
  end

  # 注文商品の小計（税込）
  def subtotal
    taxed_product_price * amount
  end
end
