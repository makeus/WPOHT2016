class AddLogoToSeller < ActiveRecord::Migration
  def change
    add_column :sellers, :logo, :string
  end
end
