class CreateShippings < ActiveRecord::Migration[5.2]
  def change
    create_table :shippings do |t|
      t.string :area, null:false
      t.integer :fee, null:false
      t.integer :handing_time, null:false
      t.timestamps
    end
  end
end
