class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      t.integer :user_id, null: false
      t.integer :pay_method, null: false, default: 0
      t.integer :postage, null: false, default: 800
      t.integer :total_price, null: false, default: 0
      t.string :zip_code, null: false
      t.string :address, null: false
      t.string :name, null: false

      t.integer :order_status, null: false, default: 0

      t.timestamps
    end
  end
end
