class AddDefaultValues < ActiveRecord::Migration
  def change
    change_column :users, :marketing, :boolean, :default => false
    change_column :users, :articles, :boolean, :default => false
    change_column :users, :digest, :boolean, :default => false
  end
end
