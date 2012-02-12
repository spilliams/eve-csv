class RemoveApiIdFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :api_id
  end

  def down
    add_column :users, :api_id, :string
  end
end
