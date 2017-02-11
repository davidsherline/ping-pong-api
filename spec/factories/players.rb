FactoryGirl.define do
  factory :player, aliases: [:first_server] do
    name { Faker::Name.unique.first_name }
  end
end
