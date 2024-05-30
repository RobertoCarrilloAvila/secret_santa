# frozen_string_literal: true

FactoryBot.define do
  factory :person do
    family { association :family }
    name { Faker::Name.name_with_middle }
  end
end
