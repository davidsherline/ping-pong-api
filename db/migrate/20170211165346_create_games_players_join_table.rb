class CreateGamesPlayersJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :games, :players do |t|
      t.references :game, foreign_key: true
      t.references :player, foreign_key: true
    end

    add_index :games_players, [:game_id, :player_id], unique: true
  end
end
