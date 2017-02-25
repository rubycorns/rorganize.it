require 'spec_helper'

describe NullPerson do
  let(:null_person) { described_class.new }
  let(:group) { build_stubbed :group }

  specify 'is not an admin' do
    expect(null_person.admin?).to be false
  end

  specify 'can_join_group?' do
    expect(null_person.can_join_group?).to be false
  end

  specify 'is a member of a group' do
    expect(null_person.member_of?(group)).to be false
  end
end