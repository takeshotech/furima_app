class RemoveProductIdFromShippings < ActiveRecord::Migration[5.2]
  def change
    remove_column :shippings, :product_id
  end
end
