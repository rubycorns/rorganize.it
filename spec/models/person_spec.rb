# == Schema Information
#
# Table name: people
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  email                  :string(255)      default(""), not null
#  type                   :string(255)
#  group_id               :integer
#  created_at             :datetime
#  updated_at             :datetime
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  picture                :string(255)
#  twitter                :string(255)
#

require 'spec_helper'

describe Person do

  it { should have_many(:groups) }
  it { should have_many(:memberships) }
  it { should have_many(:topics) }
  it { should have_many(:posts) }

  it { should validate_presence_of(:first_name) }

  let(:person)        { create(:person) }
  let!(:group)        { create(:group) }
  let!(:second_group) { create(:second_group)}

  it 'has the correct full name' do
    expect(person.full_name).to eq 'Ruby Corn'
  end

  it 'has no group' do
    expect(person.has_group?).to be_false
  end

  it 'is a minimal valid user' do
    expect(person).to be_valid
  end

  describe 'an invalid person' do
    before { person.first_name == '' }
    it { should_not be_valid }
  end

  describe '#has_group?' do
    it 'is not a member of a group' do
      expect(person.has_group?).to be_false
    end

    describe 'joining a group' do
      before { person.join!(group) }

      it 'makes a person a member of that group' do
        expect(person.has_group?).to be_true
      end
    end
  end

  describe '#join!' do
    before { person.join!(group) }

    it 'puts the person in the correct group' do
      expect(person.memberships.first.group_id).to eq group.id
    end

    describe 'joining a second group' do
      before { person.join!(second_group) }

      it 'allows the person to also be a member of the second group' do
        expect(person.member_of?(second_group)).to be_true
      end

      it 'allows the person to be a member of both groups' do
        expect(person.memberships.count).to eq 2
      end
    end
  end

  describe '#leave!' do
    before do
      membership = person.join!(group)
      person.join!(second_group)
      # because you don't leave a group, you destroy a membership
      person.leave!(membership)
    end

    it 'removes the person from the first group' do
      expect(person.member_of?(group)).to be_false
    end

    it 'does not remove the person from the second group' do
      expect(person.member_of?(second_group)).to be_true
    end
  end

  describe '#member_of?' do
    before { person.join!(group) }

    it 'checks to see if they are a member of a group' do
      expect(person.member_of?(group)).to be_true
    end
  end
end
