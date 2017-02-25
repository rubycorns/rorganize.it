require 'spec_helper'

RSpec.describe LocationFilter, vcr: {cassette_name: "create_group" } do

  describe '.filtered_by_region' do
    let(:german_person)    { create :person, country: 'DE' }
    let(:canadian_person)  { create :person, country: 'CA' }
    let(:calgarian_person) { create :person, city: 'Calgary', country: 'CA' }

    context 'when logged in' do
      it 'filters for German users' do
        params = { country: 'DE' }
        expect(Person.filtered_by_region(params)).to match_array german_person
      end

      it 'filters for Canadian users' do
        params = { country: 'CA' }
        expect(Person.filtered_by_region(params)).to match_array [canadian_person, calgarian_person]
      end

      it 'filters by multiple params' do
        params =  { country: 'CA', city: 'Calgary' }
        params2 = { country: 'DE', city: 'Calgary' }

        expect(Person.filtered_by_region(params)).to match_array [calgarian_person]
        expect(Person.filtered_by_region(params2)).to match_array []
      end
    end
  end

  describe '#country_name' do
    let(:group) { build_stubbed :group, country: 'DE' }
    let(:group_empty) { build_stubbed :group, country: nil }

    it 'is present' do
      expect(group.country_name).to eql 'Germany'
    end

    it 'is not present' do
      expect(group_empty.country_name).to eql nil
    end
  end
end