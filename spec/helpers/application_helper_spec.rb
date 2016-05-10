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
