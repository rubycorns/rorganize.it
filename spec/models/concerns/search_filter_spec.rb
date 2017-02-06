require 'spec_helper'

RSpec.describe SearchFilter, :vcr => {:cassette_name => "create_group" } do

  describe '.filtered_by_params' do
    context 'for people' do
      let(:german_person)   { create :person, country: 'DE', non_public: true}
      let(:canadian_person) { create :person, country: 'CA', city: 'Calgary', non_public: false}

      context 'when logged in' do
        it 'filters for German users' do
          params = { country: 'DE' }
          expect(Person.filtered_by_params(params, true)).to match_array german_person
        end

        it 'filters for Calgarian users' do
          params = { city: 'Calgary' }
          expect(Person.filtered_by_params(params, true)).to match_array canadian_person
        end
      end

      context 'when logged out' do
        it 'only displays users with a public profile' do
          params = {}
          expect(Person.filtered_by_params(params, false)).to match_array canadian_person
        end
      end
    end

    context 'for groups' do
      let(:german_group)   { create :group, country: 'DE' }
      let(:canadian_group) { create :group, country: 'CA', city: 'Toronto' }

      it 'filters for German groups' do
        params = { country: 'DE' }
        expect(Group.filtered_by_params(params)).to match_array german_group
      end

      it 'filters for Torontonian groups' do
        params = { city: 'Toronto' }
        expect(Group.filtered_by_params(params)).to match_array canadian_group
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