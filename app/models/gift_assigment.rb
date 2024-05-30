class GiftAssigment < ApplicationRecord
  belongs_to :giver, class_name: 'Person'
  belongs_to :recipient, class_name: 'Person'

  validates :year, presence: true
  validates :giver_id, uniqueness: { scope: %i[recipient_id year] }

  def self.current_assigment(family)
    joins(:giver)
      .where(
        year: Time.zone.today.year,
        giver: family.people
      )
  end
end
