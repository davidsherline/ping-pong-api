class Player < ApplicationRecord
  has_and_belongs_to_many :games, dependent: :restrict_with_exception,
                                  inverse_of: :players
  has_many :points, dependent: :restrict_with_exception, inverse_of: :player

  validates :name, presence: true, uniqueness: true
end
