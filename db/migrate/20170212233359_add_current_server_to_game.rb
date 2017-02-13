class AddCurrentServerToGame < ActiveRecord::Migration[5.0]
  def change
    add_reference :games, :current_server, foreign_key: true
  end
end
