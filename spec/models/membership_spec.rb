require 'spec_helper'

describe Membership do
  let(:person) { create(:person) }
  let!(:group) { create(:group) }

  before do
    person.join!(group)
  end

  subject { person.memberships.first }

  its(:name) { should eq 'Student' }
  its(:type) { should eq 'StudentMembership' }
end
