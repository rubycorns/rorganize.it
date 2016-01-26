require 'spec_helper'

RSpec.describe LocationFilter do

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