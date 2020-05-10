class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def taxed_product_price
    product.taxed_price
  end

  # 注文商品の小計（税込）
  def subtotal
    taxed_product_price * amount
  end
end
