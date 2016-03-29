require 'spec_helper'

describe 'markdown helper', :type => :helper do
  it 'filters html' do
    expect(helper.markdown('<h1>hello</h1>')).to eq("<p>hello</p>\n")
  end

  it 'converts emojis' do
    expect(helper.markdown(':coffee:')).to match(/assets\/emojis\/coffee.png/)
  end
end

describe '#country_names_for_select' do
  it 'convers the country codes to country name' do
    countries = ['DE', 'CA', 'US']
    expect(helper.country_names_for_select(countries)).to eql [["Germany", "DE"], ["Canada", "CA"], ["United States", "US"]]
  end
end

describe '#guaranteed_person' do
  context 'with no logged in person' do
    before { allow(helper).to receive(:current_person).and_return nil }

    it 'returns a null person' do
      expect(helper.guaranteed_person).to be_instance_of NullPerson
    end
  end

  context 'with a logged in person' do
    before { allow(helper).to receive(:current_person).and_return Person.new }

    it 'returns a real person' do
      expect(helper.guaranteed_person).to be_instance_of Person
    end
  end
end
