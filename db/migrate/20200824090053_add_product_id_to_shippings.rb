class AddProductIdToShippings < ActiveRecord::Migration[5.2]
  def change
    add_reference :shippings, :product, foreign_key: true
  end
end
