class CartItem < ApplicationRecord
	belongs_to :product
  belongs_to :user
  
  def subtotal
    amount * product.taxed_price
  end
end
