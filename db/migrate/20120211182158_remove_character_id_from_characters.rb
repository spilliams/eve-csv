class RemoveCharacterIdFromCharacters < ActiveRecord::Migration
  def up
    remove_column :characters, :character_id
  end

  def down
    add_column :characters, :character_id, :string
  end
end
