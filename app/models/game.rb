class Game < ApplicationRecord
  belongs_to :first_server, class_name: 'Player', optional: true
  has_and_belongs_to_many :players, inverse_of: :games

  accepts_nested_attributes_for :players, limit: 2

  enum status: [:pending, :started, :finished]
end
