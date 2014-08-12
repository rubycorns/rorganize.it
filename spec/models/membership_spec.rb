require 'spec_helper'

describe Membership do
  let(:person) { create(:person) }
  let!(:group) { create(:group) }

  before do
    person.join!(group)
  end

  subject { person.memberships.first }

  describe '#name' do
    its(:name) { is_expected.to eq 'Student' }
  end

  describe '#type' do
    its(:type) { is_expected.to eq 'StudentMembership' }
  end
end
