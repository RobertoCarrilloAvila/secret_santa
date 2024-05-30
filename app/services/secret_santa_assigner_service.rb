class SecretSantaAssignerService
  attr_reader :family, :errors

  def initialize(family)
    @family = family
    @assigned_members = []
    @errors = []
  end

  def call
    GiftAssigment.transaction do
      ordered_family_members.each do |member|
        recipient = possible_recipients(member).sample
        save_gift_assigment(member, recipient)
      end
    end

    errors.empty?
  end

  private

  attr_reader :assigned_members

  def save_gift_assigment(member, recipient)
    unless recipient
      @errors << "No possible recipients for #{member.name}"
      raise ActiveRecord::Rollback
    end

    assigned_members << recipient
    member.given_gifts.create!(recipient:, year: current_year)
  end

  def possible_recipients(member)
    ordered_family_members - excluded_members(member)
  end

  def excluded_members(member)
    [member] + member.linked_people + assigned_members + members_recently_assigned(member)
  end

  def members_recently_assigned(member)
    member.recipients.where(gift_assigments: { year: (current_year - 3)..current_year })
  end

  # returns all family members ordered by the number of relationships they have
  def ordered_family_members
    family.people
          .select('people.*, COUNT(relationships.id) AS relationships_count')
          .joins('LEFT JOIN relationships ON relationships.person_id = people.id')
          .group('people.id')
          .order('relationships_count DESC')
  end

  def current_year
    @current_year ||= Time.current.year
  end
end
