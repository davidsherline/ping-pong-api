require 'rails_helper'

RSpec.describe Player, type: :model do
  describe 'associations' do
    it do
      should have_and_belong_to_many(:games).dependent(:restrict_with_exception)
        .inverse_of(:players)
    end

    it do
      should have_many(:points).dependent(:restrict_with_exception)
        .inverse_of(:player)
    end
  end

  describe 'validations' do
    subject { create(:player) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
