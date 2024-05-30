FactoryBot.define do
  factory :family do
    name { Faker::Name.middle_name }
  end
end
