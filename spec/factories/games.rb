FactoryGirl.define do
  factory :game do
    first_server
    status :pending

    trait :started do
      status :started
    end

    trait :finished do
      status :finished
    end
  end
end
