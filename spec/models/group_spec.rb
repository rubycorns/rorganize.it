# == Schema Information
#
# Table name: groups
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  address           :string(255)
#  time              :string(255)
#  number_of_members :integer
#  created_at        :datetime
#  updated_at        :datetime
#  picture           :string(255)
#  twitter           :string(255)
#  latitude          :float
#  longitude         :float
#  contact           :text
#  activities        :text
#

require 'spec_helper'

describe Group do

  subject { Group.new }

  it 'is not valid without name' do
    expect(subject.valid?).to be_false
  end

  it 'is valid with a name' do
    subject.name = 'Awesome Test Group'
    expect(subject.valid?).to be_true
  end

  describe 'editable by' do

    it 'is editable by student in the group' do
      user = Student.new
      subject.students << user
      expect(subject.is_editable_by?(user)).to be_true
    end

    it 'is not editable by student not in the group' do
      user = Student.new
      expect(subject.is_editable_by?(user)).to be_false
    end

    it 'is editable by coach in the group' do
      user = Coach.new
      subject.coaches << user
      expect(subject.is_editable_by?(user)).to be_true
    end

    it 'is not editable by coach not in the group' do
      user = Coach.new
      expect(subject.is_editable_by?(user)).to be_false
    end

  end

end
