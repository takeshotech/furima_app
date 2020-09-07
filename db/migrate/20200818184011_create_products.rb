class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null:false
      t.text :text, null:false
      t.integer :condition, null:false
      t.integer :price, null:false
      t.integer :trading_status, null:false
      t.datetime :completed_at
      t.integer :category, null: false, foreign_key: true
      t.integer :shipping, null: false, foreign_key: true
      t.integer :brand, foreign_key:true
      t.integer :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
