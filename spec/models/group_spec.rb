require 'spec_helper'

describe Group do

  subject {Group.new}

  it 'is not valid without name' do
    expect(subject.valid?).to be_false
  end

  it 'is valid with a name' do
    subject.name = 'Awesome Test Group'
    expect(subject.valid?).to be_true
  end

end