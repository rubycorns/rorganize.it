require 'spec_helper'

describe Membership do
  let(:person) { create(:person) }
  let!(:group) { create(:group) }

  before do
    person.join!(group)
  end

  subject { person.memberships.first }

  describe '#name' do
    subject { super().name }
    it { is_expected.to eq 'Student' }
  end

  describe '#type' do
    subject { super().type }
    it { is_expected.to eq 'StudentMembership' }
  end
end
