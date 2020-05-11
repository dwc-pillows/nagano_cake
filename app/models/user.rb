class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :deliveries, dependent: :destroy


  # バリデーション
  validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }   # 全角カタカナ
  validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }   # 全角カタカナ
  validates :zip_code, format: { with: /\A\d{7}\z/ }   # 郵便番号（ハイフンなし7桁）
  validates :phone_number, format: { with: /\A\d{10,11}\z/ }  # 電話番号(ハイフンなし10桁or11桁)
  validates :email, format: { with: /\A\S+@\S+\.\S+\z/ }  # メールアドレス
  

  # カート商品合計金額（小計の合計）
  def cart_items_sum
    total = 0
    cart_items.each do |cart_item|
      total += cart_item.subtotal
    end
    total
  end

  # カート商品合計個数（各商品個数の合計）
  def cart_items_count
    count = 0
    cart_items.each do |cart_item|
      count += cart_item.amount
    end
    count
  end

  # 最新の注文が確定済みかどうか
  def unconfirmed_order?
    # .lastでも代用可（ただ今回の記述の方が拡張性が高い）
    latest_order = orders.order(created_at: :desc).take
    # 現状だとdefの命名とtrue/falseが逆になっているので逆転させる
    !latest_order.order_products.present?
  end
end
