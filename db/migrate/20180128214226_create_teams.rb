class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name, limit: 50, null: false
      t.integer :average_sr
      t.timestamps
    end
    add_index :teams, :name
  end
end
