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
end

describe '#overview_filter' do
  it 'returns the title for a given overview page, depending on filter params' do
    expect(helper.overview_filter('Groups')).to eq('Groups overview')
    params['city'] = 'Berlin'
    expect(helper.overview_filter('Groups')).to eq('Groups in Berlin')
    params['country'] = 'US'
    expect(helper.overview_filter('Groups')).to eq('Groups in Berlin, United States of America')
  end
end
