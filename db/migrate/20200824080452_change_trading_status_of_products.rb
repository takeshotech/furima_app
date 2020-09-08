class ChangeTradingStatusOfProducts < ActiveRecord::Migration[5.2]
  def up
    change_column :products, :trading_status, :integer, default: '0'
  end



  def down
    change_column :products, :trading_status, :integer, null:false
  end
end
