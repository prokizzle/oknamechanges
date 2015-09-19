class AddAttributesToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :city, :string, default: ""
    add_column :matches, :state, :string, default: ""
    add_column :matches, :gender, :string, default: ""
  end
end
