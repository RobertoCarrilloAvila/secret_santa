FactoryBot.define do
  factory :person do
    family { association :family }
    name { Faker::Name.name_with_middle }
  end
end
