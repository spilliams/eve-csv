class AddCharacterIdToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :character_id, :string
  end
end
