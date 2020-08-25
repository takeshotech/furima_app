class RenemeTypeColumnToShipping < ActiveRecord::Migration[5.2]
  def change
    rename_column :shippings, :type, :shipping_type
  end
end
