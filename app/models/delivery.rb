class Delivery < ApplicationRecord
  belongs_to :user

  
  # バリデーション
  validates :zip_code, presence: true, format: {with: /\A\d{7}\z/}   # 郵便番号（ハイフンなし7桁）


  def destination
    zip_code + " " + address + " " + name
  end
end
