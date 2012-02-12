class AddCurrentCharacterToUsers < ActiveRecord::Migration
  def up
    remove_column :users, :character_id
    add_column :users, :current_character_id, :integer
    add_column :users, :default_character_id, :integer    
  end

  def down
    add_column :users, :character_id, :string
    remove_column :users, :current_character_id, :integer
    remove_column :users, :default_character_id, :integer
  end
end
