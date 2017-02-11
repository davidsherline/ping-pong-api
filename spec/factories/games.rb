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
  end
end
