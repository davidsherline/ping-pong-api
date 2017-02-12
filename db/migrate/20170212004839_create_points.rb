class CreatePoints < ActiveRecord::Migration[5.0]
  def change
    create_table :points do |t|
      t.references :game, foreign_key: true, null: false
      t.references :player, foreign_key: true, null: false

      t.timestamps
    end

    add_index :points, [:game_id, :player_id]
  end
end
