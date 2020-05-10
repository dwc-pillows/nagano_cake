class Order < ApplicationRecord
  has_many :order_products, dependent: :destroy
  belongs_to :user

  enum pay_method: {"クレジットカード": 0, "銀行振り込み": 1}

  # バリデーション 
  validates :zip_code, format: { with: /\A\d{7}\z/ }   # 郵便番号（ハイフンなし7桁）


  def total_price
    total = 0
    order_products.each do |order_product|
      total += order_product.subtotal
    end
    total + postage
  end
end
