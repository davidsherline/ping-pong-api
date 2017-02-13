require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'associations' do
    it { should belong_to(:first_server).class_name('Player') }
    it { should belong_to(:current_server).class_name('Player') }
    it { should have_and_belong_to_many(:players).inverse_of(:games) }
    it { should have_many(:points).dependent(:destroy).inverse_of(:game) }
    it { should accept_nested_attributes_for(:players).limit(2) }
  end

  describe '#status' do
    it do
      should define_enum_for(:status)
        .with([:pending, :started, :deuce, :finished])
    end
  end

  describe '#first_receiver' do
    let(:game) { create(:game, :with_players) }

    context 'when there is no first server' do
      it 'should return nil' do
        expect(game.first_receiver).to be(nil)
      end
    end

    context 'when there is a first server' do
      let(:first_server) { game.players.first }
      let(:first_receiver) { game.players.last }

      before(:each) { game.update_attribute(:first_server, first_server) }

      it 'should return the first receiver' do
        expect(game.first_receiver).to eq(first_receiver)
      end
    end
  end

  describe '#first_server=' do
    let(:game) { create(:game, :with_players) }

    context 'when first server is not a player' do
      let(:first_server) { create(:player) }

      it 'should raise ActiveModel::StrictValidationFailed' do
        expect { game.first_server = first_server }
          .to raise_error(ActiveModel::StrictValidationFailed)
      end
    end

    context 'when first server is a player' do
      let(:first_server) { game.players.first }

      before(:each) { game.first_server = first_server }

      it 'should set the first server' do
        expect(game.first_server).to eq(first_server)
      end

      it 'should set the current server' do
        expect(game.current_server).to eq(first_server)
      end
    end
  end

  describe '#current_server=' do
    let(:game) { create(:game, :with_players) }

    context 'when current server is not a player' do
      let(:current_server) { create(:player) }

      it 'should raise ActiveModel::StrictValidationFailed' do
        expect { game.current_server = current_server }
          .to raise_error(ActiveModel::StrictValidationFailed)
      end
    end

    context 'when current server is a player' do
      let(:current_server) { game.players.first }

      before(:each) { game.current_server = current_server }

      it 'should set the current server' do
        expect(game.current_server).to eq(current_server)
      end
    end
  end

  describe '#score_for' do
    let(:game) { create(:game, :with_players) }

    context 'with a player that has no points' do
      let(:player) { game.players.first }

      it 'should return 0' do
        expect(game.score_for(player)).to eq(0)
      end
    end

    context 'with a player that has 5 points' do
      let(:player) { game.players.first }

      before(:each) { create_list(:point, 5, player: player, game: game) }

      it 'should return 5' do
        expect(game.score_for(player)).to eq(5)
      end
    end
  end

  describe '#opponent_for' do
    let(:game) { create(:game, :with_players) }
    let(:player) { game.players.first }
    let(:opponent) { game.players.last }

    it 'should return the opponent' do
      expect(game.opponent_for(player)).to eq(opponent)
    end
  end
end
