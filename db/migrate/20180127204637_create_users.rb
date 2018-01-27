class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :battletag, null: false
      t.string :provider, null: false
      t.string :uid, null: false
      t.timestamps null: false
    end

    add_index :users, :battletag, unique: true
    add_index :users, [:provider, :uid], unique: true
  end
end
