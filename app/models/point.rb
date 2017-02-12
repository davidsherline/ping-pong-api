class Point < ApplicationRecord
  belongs_to :game, inverse_of: :points
  belongs_to :player, inverse_of: :points
end
