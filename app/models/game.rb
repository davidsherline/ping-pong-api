class Game < ApplicationRecord
  belongs_to :first_server, class_name: 'Player', optional: true
  has_and_belongs_to_many :players, inverse_of: :games
  has_many :points, dependent: :destroy, inverse_of: :game

  accepts_nested_attributes_for :players, limit: 2

  enum status: [:pending, :started, :finished]

  def first_server=(player)
    return super(player) if players.include?(player)

    errors.add(:first_server, :invalid, message: 'must be a player',
                                        strict: true)
  end

  def score_for(player)
    points.score_for(player)
  end
end
