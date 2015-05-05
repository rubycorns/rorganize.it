require 'spec_helper'

describe 'markdown helper', :type => :helper do

  it 'filters html' do
    expect(helper.markdown('<h1>hello</h1>')).to eq("<p>hello</p>\n")
  end

  it 'converts emojis' do
    expect(helper.markdown(':coffee:')).to match(/assets\/emojis\/coffee.png/)
  end
end
