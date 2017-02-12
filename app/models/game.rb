class Game < ApplicationRecord
  belongs_to :first_server, ->(game) { where(id: game.players.pluck(:id)) },
             class_name: 'Player', optional: true
  has_and_belongs_to_many :players, inverse_of: :games
  has_many :points, dependent: :destroy, inverse_of: :game

  accepts_nested_attributes_for :players, limit: 2

  enum status: [:pending, :started, :finished]
end
