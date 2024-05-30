class Relationship < ApplicationRecord
  RELATIONSHIP_TYPE = {
    'parent' => 'child',
    'child' => 'parent',
    'sibling' => 'sibling',
    'wife' => 'husband',
    'husband' => 'wife',
    'grandparent' => 'grandchild',
    'grandchild' => 'grandparent'
  }.freeze

  belongs_to :person
  belongs_to :linked_person, class_name: 'Person'

  validates :relationship_type, presence: true
  validates :person_id, uniqueness: { scope: :linked_person_id }

  after_create :create_inverse_relationship, unless: :inverse_relationship_exists?
  after_destroy :destroy_inverse_relationship, if: :inverse_relationship_exists?

  private

  def create_inverse_relationship
    ActiveRecord::Base.transaction do
      Relationship.create!(
        person: linked_person,
        linked_person: person,
        relationship_type: inverse_relationship_type
      )
    end
  end

  def destroy_inverse_relationship
    inverse_relationship = Relationship.find_by(
      person: linked_person,
      linked_person: person,
      relationship_type: inverse_relationship_type
    )
    inverse_relationship&.destroy
  end

  def inverse_relationship_exists?
    Relationship.exists?(
      person: linked_person,
      linked_person: person,
      relationship_type: inverse_relationship_type
    )
  end

  def inverse_relationship_type
    RELATIONSHIP_TYPE[relationship_type] || relationship_type
  end
end
