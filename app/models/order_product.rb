class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def taxed_product_price
    product.taxed_price
  end
end
