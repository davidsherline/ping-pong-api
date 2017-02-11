class Game < ApplicationRecord
  belongs_to :first_server, class_name: 'Player'

  enum status: [:pending, :started, :finished]
end
