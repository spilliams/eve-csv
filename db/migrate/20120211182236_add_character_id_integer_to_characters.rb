class AddCharacterIdIntegerToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :character_id, :integer
  end
end
