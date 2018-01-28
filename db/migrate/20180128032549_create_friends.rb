class CreateFriends < ActiveRecord::Migration[5.1]
  def change
    create_table :friends, id: false do |t|
      t.integer :user1_id, null: false
      t.integer :user2_id, null: false
    end
  end
end
