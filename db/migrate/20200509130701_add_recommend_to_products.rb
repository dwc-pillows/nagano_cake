class AddRecommendToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :recommend, :boolean, null: false, default: true
  end
end
