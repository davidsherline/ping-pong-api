require 'rails_helper'

RSpec.describe Player, type: :model do
  describe 'associations' do
    it { should have_and_belong_to_many(:games).inverse_of(:games) }
  end

  describe 'validations' do
    subject { create(:player) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
