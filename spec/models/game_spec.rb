require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'associations' do
    it { should belong_to(:first_server).class_name('Player') }
  end

  describe '#status' do
    it { should define_enum_for(:status).with([:pending, :started, :finished]) }
  end
end
