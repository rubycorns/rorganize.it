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
  it 'converts the country codes to country name' do
    countries = ['DE', 'CA', 'US']
    expect(helper.country_names_for_select(countries)).to eql [["Germany", "DE"], ["Canada", "CA"], ["United States of America", "US"]]
  end
end

describe '#country_name_from_code' do
  it 'returns a single country name from a single country code' do
    country = "FR"
    expect(helper.country_name_from_code(country)).to eq('France')
  end

  it 'raises NoSuchCountry when country is invalid' do
    country = 'foofoofoo'
    expect { helper.country_name_from_code(country) }.to raise_error(NoSuchCountry)
  end
end

describe '#overview_filter' do
  context "when only country/only city/both country and city are given as parameters" do
    it "returns the string with only the country/the city/the country city in it" do
      expect(helper.overview_filter('Groups')).to eq('Groups overview')
      params['city'] = 'Berlin'
      expect(helper.overview_filter('Groups')).to eq('Groups in Berlin')
      params['country'] = 'US'
      expect(helper.overview_filter('Groups')).to eq('Groups in Berlin, United States of America')
    end
  end

  describe '#split_mastodon_handle' do
    let(:person) { build_stubbed :person, { mastodon: 'seunadex@mastodon.social' } }
    it 'splits users mastodon handle and returns a hash' do
      arr = helper.split_mastodon_handle(person.mastodon)
      expect(arr[:username]).to eq('seunadex')
      expect(arr[:host]).to eq('mastodon.social')
    end
  end
end
