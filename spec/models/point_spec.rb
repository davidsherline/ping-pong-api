require 'rails_helper'

RSpec.describe Point, type: :model do
  it { should belong_to(:game).inverse_of(:points) }
  it { should belong_to(:player).inverse_of(:points) }
end
