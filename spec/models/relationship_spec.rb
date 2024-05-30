# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationship do
  describe 'associations' do
    it { is_expected.to belong_to(:person) }
    it { is_expected.to belong_to(:linked_person).class_name('Person') }
  end

  describe 'validations' do
    subject { build(:relationship) }

    it { is_expected.to validate_presence_of(:relationship_type) }
    it { is_expected.to validate_uniqueness_of(:person_id).scoped_to(:linked_person_id) }
  end

  describe 'callbacks' do
    let(:father) { create(:person) }
    let(:son) { create(:person) }
    let(:inverse_relationship) do
      described_class.find_by(person: son, linked_person: father, relationship_type: 'child')
    end

    describe 'after_create' do
      let(:relationship) { build(:relationship, person: father, linked_person: son, relationship_type: 'parent') }

      it 'creates an inverse relationship' do
        expect { relationship.save }.to change(described_class, :count).by(2)
      end

      it 'creates the correct inverse relationship' do
        relationship.save
        expect(inverse_relationship).to be_present
      end
    end

    describe 'after_destroy' do
      let!(:relationship) { create(:relationship, person: father, linked_person: son, relationship_type: 'parent') }

      it 'destroys the inverse relationship' do
        expect { relationship.destroy }.to change(described_class, :count).by(-2)
      end

      it 'destroys the correct inverse relationship' do
        relationship.destroy
        expect(inverse_relationship).not_to be_present
      end
    end
  end
end
