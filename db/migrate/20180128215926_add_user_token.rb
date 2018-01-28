class AddUserToken < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :api_token, :string, limit: 20
    add_index :users, [:api_token, :battletag], unique: true

    change_column :users, :battletag, :string, limit: 30, null: false
  end

  def down
    change_column :users, :battletag, :string, null: false, limit: nil

    remove_column :users, :api_token
  end
end
