# frozen_string_literal: true

FactoryBot.define do
  factory :family do
    name { Faker::Name.middle_name }
  end
end
