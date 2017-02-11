FactoryGirl.define do
  factory :player do
    name { Faker::Name.unique.first_name }
  end
end
