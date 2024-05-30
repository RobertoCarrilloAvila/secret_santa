# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Person do
  describe 'table' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:family) }
    it { is_expected.to have_many(:relationships) }
    it { is_expected.to have_many(:linked_people).through(:relationships).source(:linked_person) }
  end
end
