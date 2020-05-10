class Order < ApplicationRecord
  has_many :order_products, dependent: :destroy
  belongs_to :user

  enum pay_method: {
    "クレジットカード": 0,
    "銀行振り込み": 1
  }
  enum order_status: {
    "入金待ち": 0,
    "入金確定": 1,
    "制作中": 2,
    "発送準備中": 3,
    "発送済み": 4
  }
end
