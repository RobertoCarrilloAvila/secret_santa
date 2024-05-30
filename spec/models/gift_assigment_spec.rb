require 'rails_helper'

RSpec.describe GiftAssigment do
  describe 'validations' do
    subject { build(:gift_assigment) }

    it { is_expected.to validate_presence_of(:year) }
    it { is_expected.to validate_uniqueness_of(:giver_id).scoped_to(%i[recipient_id year]) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:giver) }
    it { is_expected.to belong_to(:recipient) }
  end
end
