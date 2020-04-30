class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|

      t.integer :genre_id, null: false
      t.string :name, null: false
      t.string :image_id
      t.text :description, null: false, default: "商品説明"
      t.integer :price, null: false
      t.boolean :is_active, null: false, default: true
      

      t.timestamps
    end
  end
end
