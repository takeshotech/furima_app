class ChangeDataShippingToShippingType < ActiveRecord::Migration[5.2]
  def change
    change_column :shippings, :shipping_type, :integer
  end
end
