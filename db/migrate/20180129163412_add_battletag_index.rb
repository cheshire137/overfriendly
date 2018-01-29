class AddBattletagIndex < ActiveRecord::Migration[5.1]
  def change
    add_index :team_players, :battletag
  end
end
