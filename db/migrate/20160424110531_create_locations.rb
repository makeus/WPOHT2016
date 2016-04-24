class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :card_id
      t.string :country
      t.string :address

      t.timestamps null: false
    end
  end
end
