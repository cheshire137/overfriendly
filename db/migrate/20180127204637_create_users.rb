class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :battletag, null: false
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :platform, limit: 3
      t.string :region, limit: 6
      t.timestamps null: false
    end

    add_index :users, :battletag, unique: true
    add_index :users, [:provider, :uid], unique: true
  end
end
