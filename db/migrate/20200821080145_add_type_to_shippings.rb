class AddTypeToShippings < ActiveRecord::Migration[5.2]
  def change
    add_column :shippings, :type, :string
  end
end
