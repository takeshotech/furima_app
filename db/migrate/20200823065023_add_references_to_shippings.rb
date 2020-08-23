class AddReferencesToShippings < ActiveRecord::Migration[5.2]
  def change
    add_reference :shippings, :product, null: false, foreign_key: true
  end
end
