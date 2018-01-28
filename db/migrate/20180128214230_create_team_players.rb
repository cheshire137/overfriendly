class CreateTeamPlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :team_players do |t|
      t.integer :team_id, null: false
      t.integer :user_id
      t.string :name, limit: 30
      t.string :battletag, limit: 30
      t.string :role, limit: 10
      t.timestamps
    end
    add_index :team_players, :team_id
    add_index :team_players, :user_id
  end
end
