class CreateUsernameChanges < ActiveRecord::Migration
  def change
    create_table :username_changes do |t|
      t.string :old_name
      t.string :new_name
    end
  end
end
