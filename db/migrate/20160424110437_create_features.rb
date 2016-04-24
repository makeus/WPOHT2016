class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.integer :card_id
      t.string :type
      t.string :value

      t.timestamps null: false
    end
  end
end
