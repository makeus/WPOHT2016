class CreateSellers < ActiveRecord::Migration
  def change
    create_table :sellers do |t|
      t.string :name
      t.string :email
      t.string :image
      t.string :company

      t.timestamps null: false
    end
  end
end
