class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.references :first_server, foreign_key: true
      t.integer :status, default: 0, null: false

      t.timestamps
    end

    add_index :games, :status
  end
end
