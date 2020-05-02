class RenameOrderIdColumnToDeliveries < ActiveRecord::Migration[5.2]
  def change
    rename_column :deliveries, :order_id, :user_id
  end
end
