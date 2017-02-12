require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'associations' do
    it { should belong_to(:first_server).class_name('Player') }
    it { should have_and_belong_to_many(:players).inverse_of(:games) }
    it { should have_many(:points).dependent(:destroy).inverse_of(:game) }
    it { should accept_nested_attributes_for(:players).limit(2) }
  end

  describe '#status' do
    it { should define_enum_for(:status).with([:pending, :started, :finished]) }
  end

  describe '#first_server=' do
    let(:game) { create(:game, :with_players) }

    context 'when first server is a player' do
      let(:first_server) { create(:player) }

      it 'should raise ActiveModel::StrictValidationFailed' do
        expect { game.first_server = first_server }
          .to raise_error(ActiveModel::StrictValidationFailed)
      end
    end

    context 'when first server is not a player' do
      let(:first_server) { game.players.first }

      it 'should set the first player' do
        expect(game.first_server = first_server).to eq(first_server)
      end
    end
  end
end
