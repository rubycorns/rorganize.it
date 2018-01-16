# == Schema Information
#
# Table name: memberships
#
#  id         :integer          not null, primary key
#  group_id   :integer
#  person_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  type       :string(255)
#

require 'spec_helper'

describe Membership, vcr: {cassette_name: 'create_group'} do
  let(:person) { create(:person) }
  let!(:group) { create(:group) }

  before do
    person.join!(group, {})
  end

  subject { person.memberships.first }

  describe '#name' do
    its(:name) { is_expected.to eq 'Student' }
  end

  describe '#type' do
    its(:type) { is_expected.to eq 'StudentMembership' }
  end
end
