class AddDefaultCharacterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :default_character, :boolean
  end
end
