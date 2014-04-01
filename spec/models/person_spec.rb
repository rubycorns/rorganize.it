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

  let(:minimal_attributes) {{ email:      'a@b.de',
                              password:   'qwe123qwe',
                              first_name: 'klaus'}}

  subject {Person.new({first_name: 'testaron',
                       last_name:  'testerson'})} #what to test? no twitter handle

  it 'has the correct full name' do
    expect(subject.full_name).to eq 'testaron testerson'
  end

  it 'has no group' do 
    expect(subject.has_group?).to be_false
  end 

  it 'is a minimal valid user' do
    expect(Person.new(minimal_attributes)).to be_valid
  end

  it 'is not valid without a first name' do
    invalid_hash = minimal_attributes.except :first_name
    expect(Person.new invalid_hash).to_not be_valid
  end

  it 'is not valid with a blank name' do
    invalid_hash = minimal_attributes.merge({first_name: ''})
    expect(Person.new invalid_hash).not_to be_valid
  end

  describe 'with group' do

    let(:group) {Group.new({name: 'test group'})}

    before :each do
      subject.join(group)
    end

    it 'has a group' do
      expect(subject.has_group?).to be_true
    end

    it 'returns a group name' do
      expect(subject.group).to eq group
    end 

  end

end
