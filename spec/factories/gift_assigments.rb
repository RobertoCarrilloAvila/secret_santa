FactoryBot.define do
  factory :gift_assigment do
    giver { association :person }
    recipient { association :person }
    year { (Time.zone.today - 5.years).year }
  end
end
