class RemoveDefaultCharacterFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :default_character
  end

  def down
    add_column :users, :default_character, :boolean
  end
end
