require 'spec_helper'

describe 'markdown helper', :type => :helper do

  it 'filters html' do
    expect(helper.markdown('<h1>hello</h1>')).to eq("<p>hello</p>\n")
  end
end
