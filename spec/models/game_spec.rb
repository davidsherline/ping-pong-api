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
end
