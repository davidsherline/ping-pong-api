class Player < ApplicationRecord
  has_and_belongs_to_many :games, inverse_of: :games

  validates :name, presence: true, uniqueness: true
end
