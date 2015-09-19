class AddInactiveToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :inactive, :boolean
  end
end
