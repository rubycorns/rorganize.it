require 'spec_helper'

describe Person do

  subject {Person.new({first_name: 'testie', last_name: 'testerson'})} #what to test? no twitter handle 

  it 'has the correct full name' do
    expect(subject.full_name).to eq 'testie testerson'
  end


  it 'has no group' do 
  	expect(subject.has_group?).to be_false
  end	

  describe 'with group' do

  	let(:group) {Group.new({name: 'test group'})}

  	before :each do
  		subject.group = group
  	end

  	it 'has a group' do
  		expect(subject.has_group?).to be_true
  	end

  	 it 'returns a group name' do
	  	expect(subject.group).to eq group
	  end	

  end

end
