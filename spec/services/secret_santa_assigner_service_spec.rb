require 'rails_helper'

RSpec.describe SecretSantaAssignerService do
  let(:service) { described_class.new(family) }

  shared_context 'family with members' do
    let(:family) { create(:family) }

    let(:grandma) { create(:person, name: 'grandma', family:) }
    let(:grandpa) { create(:person, name: 'grandpa', family:) }

    let(:mom) { create(:person, name: 'mom', family:) }
    let(:dad) { create(:person, name: 'dad', family:) }
    let(:child) { create(:person, name: 'child', family:) }

    let(:aunt) { create(:person, name: 'aunt', family:) }
    let(:uncle) { create(:person, name: 'uncle', family:) }
    let(:cousin) { create(:person, name: 'cousin', family:) }

    let!(:grandparents_relationship) do
      create(:relationship, person: grandpa, linked_person: grandma, relationship_type: 'spouse')
    end
    let!(:grandma_mom_relationship) do
      create(:relationship, person: grandma, linked_person: mom, relationship_type: 'parent')
    end
    let!(:grandpa_mom_relationship) do
      create(:relationship, person: grandpa, linked_person: mom, relationship_type: 'parent')
    end
    let!(:grandma_aunt_relationship) do
      create(:relationship, person: grandma, linked_person: aunt, relationship_type: 'parent')
    end
    let!(:grandpa_aunt_relationship) do
      create(:relationship, person: grandpa, linked_person: aunt, relationship_type: 'parent')
    end

    let!(:mom_aunt_relationship) do
      create(:relationship, person: mom, linked_person: aunt, relationship_type: 'sibling')
    end

    let!(:parents_relationship) { create(:relationship, person: dad, linked_person: mom, relationship_type: 'spouse') }
    let!(:dad_child_relationship) do
      create(:relationship, person: dad, linked_person: child, relationship_type: 'parent')
    end
    let!(:mom_child_relationship) do
      create(:relationship, person: mom, linked_person: child, relationship_type: 'parent')
    end

    let!(:aunt_uncle_relationship) do
      create(:relationship, person: aunt, linked_person: uncle, relationship_type: 'spouse')
    end
    let!(:aunt_cousin_relationship) do
      create(:relationship, person: aunt, linked_person: cousin, relationship_type: 'parent')
    end
    let!(:uncle_cousin_relationship) do
      create(:relationship, person: uncle, linked_person: cousin, relationship_type: 'parent')
    end
  end

  describe '#call' do
    context 'when everyone can be assigned' do
      include_context 'family with members'

      let(:gift_assigments) { GiftAssigment.all }

      it 'creates a gift assigment for each member' do
        expect { service.call }.to change(GiftAssigment, :count).by(8)
      end

      it 'assigns a recipient to each member' do
        service.call

        expect(gift_assigments.pluck(:recipient_id).sort).to eq(family.people.reload.pluck(:id).sort)
      end

      it 'does not assign a member to themselves' do
        service.call

        expect(gift_assigments.all? { |gift_assigment| gift_assigment.giver != gift_assigment.recipient }).to be(true)
      end

      it 'returns true' do
        expect(service.call).to be(true)
      end
    end

    context 'when a member has no possible recipients' do
      let(:family) { parent.family }
      let(:parent) { create(:person, name: 'parent') }
      let(:child) { create(:person, name: 'child', family:) }

      let!(:parent_child_relationship) do
        create(:relationship, person: parent, linked_person: child, relationship_type: 'parent')
      end

      it 'does not create any gift assigments' do
        expect { service.call }.not_to change(GiftAssigment, :count)
      end

      it 'adds an error message' do
        service.call

        expect(service.errors).to include("No possible recipients for #{parent.name}")
      end

      it 'returns false' do
        expect(service.call).to be(false)
      end
    end

    context 'when the possible recipients were recently assigned' do
      include_context 'family with members'

      let!(:uncle_gift_assigment) { create(:gift_assigment, giver: mom, recipient: uncle, year: Time.current.year - 1) }
      let!(:cousin_gift_assigment) do
        create(:gift_assigment, giver: mom, recipient: cousin, year: Time.current.year - 2)
      end

      it 'does not create any gift assigments' do
        expect { service.call }.not_to change(GiftAssigment, :count)
      end

      it 'adds an error message' do
        service.call

        expect(service.errors).to include("No possible recipients for #{mom.name}")
      end

      it 'returns false' do
        expect(service.call).to be(false)
      end
    end
  end
end
