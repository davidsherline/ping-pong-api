class Point < ApplicationRecord
  belongs_to :game, inverse_of: :points, touch: true
  belongs_to :player, inverse_of: :points

  before_create :game_finished, if: 'game.finished?'

  scope :score_for, ->(player) { where(player: player).size }

  private

  def game_finished
    errors.add(:game, :invalid, message: 'already finished', strict: true)
  end
end
