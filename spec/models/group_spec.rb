# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address    :string(255)
#  time       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  picture    :string(255)
#  twitter    :string(255)
#  latitude   :float
#  longitude  :float
#  contact    :text
#  activities :text
#  email      :string(255)
#  level      :string(255)
#  founded_on :string(255)
#  full       :boolean          default(FALSE)
#  city       :string(255)
#  country    :string(255)
#  slug       :string(255)
#  zip        :string(255)
#  street     :string(255)
#

require 'spec_helper'

describe Group, vcr: {cassette_name: 'create_group'} do

  let!(:group) { create(:group) }
  let!(:person) { create(:person) }


  it 'is valid with a name and email' do
    expect(group.valid?).to be_truthy
  end

  describe '#editable_by?' do

    it 'is editable by people in the group' do
      person.join!(group, {})
      expect(group.editable_by?(person)).to be_truthy
    end

    it 'is not editable by people not in the group' do
      expect(group.editable_by?(person)).to be_falsey
    end
  end

  describe '#deletable_by?' do

    it 'is not deletable by a person that just joined' do
      person.join!(group, {})
      expect(group).not_to be_deletable_by person
    end

    it 'is deletable by an admin' do
      person.update_attribute(:admin, true)
      expect(group).to be_deletable_by person
    end

    it 'handles nil values for not logged in users gracefully' do
      expect(group).not_to be_deletable_by nil
    end

  end

  describe '#not_full?' do
    it 'is full' do
      group.full = true
      expect(group.not_full?).to be false
    end
  end

  describe '#active?' do
    it 'is active' do
      group.inactive = false
      expect(group.active?).to be true
    end
  end

  context 'filtering by city or country' do
    let!(:group) { create :group }
    let!(:second_group) { create :second_group }

    describe '.cities' do
      it 'returns a list of cities' do
        expect(Group.cities).to eq ['Berlin', 'Hamburg']
      end
    end

    describe '.countries' do
      it 'returns a list of countries' do
        expect(Group.countries).to eq ['DE']
      end
    end
  end
end
