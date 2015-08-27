class AddNameIndexToMatches < ActiveRecord::Migration
  def change
    add_index :matches, :name, unique: true
  end
end
