class CreateDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :deliveries do |t|

       t.integer :order_id, null: false
       t.string :zip_code, null: false
       t.string :address, null: false
       t.string :name, null: false
       

      t.timestamps
    end
  end
end
