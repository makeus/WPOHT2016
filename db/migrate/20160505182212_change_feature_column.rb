class ChangeFeatureColumn < ActiveRecord::Migration
  def change
    rename_column :features, :type, :feature
  end
end
