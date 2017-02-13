require 'rails_helper'

RSpec.describe Point, type: :model do
  it { should belong_to(:game).inverse_of(:points).touch(true) }
  it { should belong_to(:player).inverse_of(:points) }

  describe '#game_finished' do
    let(:game) { create(:game, :with_players) }
    let(:player) { game.players.first }

    context 'when game is not finished' do
      before(:each) { Point.create(game: game, player: player) }

      it 'should create the point' do
        expect(Point.count).to eq(1)
      end
    end

    context 'when game is finished' do
      before(:each) { game.finished! }

      it 'should raise ActiveModel::StrictValidationFailed' do
        expect { Point.create(game: game, player: player) }
          .to raise_error(ActiveModel::StrictValidationFailed)
      end
    end
  end
end
