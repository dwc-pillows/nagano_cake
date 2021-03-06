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
    # 新規登録後注文newするまではnil,newしたらpresent?=>true
    if orders.last.nil?
      false
    else
      # presentしているので初めて特定できるようになる。
      latest_order = orders.last
      # 新規登録後new画面内でorder_productsは[],nil?=>false,present?=>false
      # 例の如く定義名にあわせて真偽値逆転
      !latest_order.order_products.present?
    end
  end
end
