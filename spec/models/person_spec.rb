require 'spec_helper'

describe Person do

  subject {Person.new({first_name: 'testie', last_name: 'testerson'})}

  it 'has the correct full name' do
    expect(subject.full_name).to eq 'testie testerson'
  end

end