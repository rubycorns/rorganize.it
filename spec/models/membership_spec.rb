require 'spec_helper'

describe Membership do
  let(:person) { create(:person) }
  let!(:group) { create(:group) }

  describe '#name' do
    before { person.join!(group) }

    it 'assigns a person their correct membership type' do
      expect(person.memberships.first.name).to eq 'Student'
    end
  end
end
