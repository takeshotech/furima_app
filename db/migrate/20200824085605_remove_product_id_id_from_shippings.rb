class RemoveProductIdIdFromShippings < ActiveRecord::Migration[5.2]
  def change
    remove_column :shippings, :product_id_id
  end
end
