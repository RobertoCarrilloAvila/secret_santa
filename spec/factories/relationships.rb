FactoryBot.define do
  factory :relationship do
    person { association :person }
    linked_person { association :person }
    relationship_type { Relationship::RELATIONSHIP_TYPE.keys.sample }
  end
end
