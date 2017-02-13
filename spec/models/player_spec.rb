require 'rails_helper'

RSpec.describe Player, type: :model do
  describe 'associations' do
    it { should have_and_belong_to_many(:games).inverse_of(:players) }

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

  describe '#player_has_games' do
    let(:player) { create(:player) }

    context 'when the player does not have games' do
      before(:each) { player.destroy! }

      it 'should destroy the user' do
        expect(player.destroyed?).to be(true)
      end
    end

    context 'when the player has games' do
      let!(:game) { create(:game, players: [player]) }

      it 'should raise ActiveModel::StrictValidationFailed' do
        expect { player.destroy! }
          .to raise_error(ActiveModel::StrictValidationFailed)
      end
    end
  end
end
