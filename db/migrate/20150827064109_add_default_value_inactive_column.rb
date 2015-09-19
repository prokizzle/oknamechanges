class AddDefaultValueInactiveColumn < ActiveRecord::Migration
  def change
    change_column :matches, :inactive, :boolean, default: false
  end
end
