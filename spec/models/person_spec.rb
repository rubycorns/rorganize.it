# == Schema Information
#
# Table name: people
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  email                  :string(255)      default(""), not null
#  type                   :string(255)
#  group_id               :integer
#  created_at             :datetime
#  updated_at             :datetime
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  picture                :string(255)
#  twitter                :string(255)
#

require 'spec_helper'

describe Person do

  subject {Person.new({first_name: 'testaron', last_name: 'testerson'})} #what to test? no twitter handle 

  it 'has the correct full name' do
    expect(subject.full_name).to eq 'testaron testerson'
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
