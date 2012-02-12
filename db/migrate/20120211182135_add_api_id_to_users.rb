class AddApiIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :api_id, :integer
  end
end
