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

describe Person, :type => :model do

  it { is_expected.to have_many(:groups) }
  it { is_expected.to have_many(:memberships) }
  it { is_expected.to have_many(:topics) }
  it { is_expected.to have_many(:posts) }

  it { is_expected.to validate_presence_of(:first_name) }

  let(:person)        { create(:person) }
  let!(:group)        { create(:group) }
  let!(:second_group) { create(:second_group)}

  subject { person }

  it 'has the correct full name' do
    expect(subject.full_name).to eq 'Ruby Corn'
  end

  it 'has no group' do
    expect(subject.has_group?).to be_falsey
  end

  it 'is a minimal valid user' do
    expect(subject).to be_valid
  end

  describe 'an invalid person' do
    before { subject.first_name = '' }

    it { is_expected.not_to be_valid }
  end

  describe '#has_group?' do
    it 'is not a member of a group' do
      expect(subject.has_group?).to be_falsey
    end

    describe 'joining a group' do
      before { subject.join!(group) }

      it 'makes a person a member of that group' do
        expect(subject.has_group?).to be_truthy
      end
    end
  end

  describe '#join!' do
    before { subject.join!(group) }

    it 'puts the person in the correct group' do
      expect(subject.memberships.first.group_id).to eq group.id
    end

    describe 'joining a second group' do
      before { subject.join!(second_group) }

      it 'allows the person to also be a member of the second group' do
        expect(subject.member_of?(second_group)).to be_truthy
      end

      it 'allows the person to be a member of both groups' do
        expect(subject.memberships.count).to eq 2
      end
    end
  end

  describe '#member_of?' do
    before { subject.join!(group) }

    it 'checks to see if they are a member of a group' do
      expect(subject.member_of?(group)).to be_truthy
    end
  end
end
