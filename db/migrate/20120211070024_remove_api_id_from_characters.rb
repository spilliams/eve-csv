class RemoveApiIdFromCharacters < ActiveRecord::Migration
  def up
    remove_column :characters, :api_id
  end

  def down
    add_column :characters, :api_id, :string
  end
end
