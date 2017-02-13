class Player < ApplicationRecord
  has_and_belongs_to_many :games, inverse_of: :players
  has_many :points, dependent: :restrict_with_exception, inverse_of: :player

  validates :name, presence: true, uniqueness: true

  before_destroy :player_has_games, unless: 'games.empty?'

  private

  def player_has_games
    errors.add(:games, :invalid, message: 'player has games', strict: true)
  end
end
