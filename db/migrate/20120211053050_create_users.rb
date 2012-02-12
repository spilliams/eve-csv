class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :api_id
      t.string :api_key

      t.timestamps
    end
  end
end
