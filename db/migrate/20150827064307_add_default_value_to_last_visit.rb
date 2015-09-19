class AddDefaultValueToLastVisit < ActiveRecord::Migration
  def change
    change_column :matches, :last_visited, :integer, default: 0
  end
end
