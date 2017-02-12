FactoryGirl.define do
  factory :game do
    status :pending

    trait :started do
      status :started
    end

    trait :finished do
      status :finished
    end

    trait :with_first_server do
      first_server
    end

    trait :with_players do
      after(:create) do |game|
        game.players << create_pair(:player)
      end
    end
  end
end
