require 'spec_helper'

describe GroupsHelper do

  describe 'show_join_group_button?' do

    subject do
      helper.show_join_group_button? person, group
    end

    let(:group) { double }

    context 'person is nil' do

      let(:person) { nil }

      it 'is true' do
        subject.should be_true
      end
    end

    context 'person is not nil' do

      let(:person) { double }

      it 'is true when person is not in group' do
        person.stub(member_of?: false)
        subject.should be_true
      end

      it 'is false when person is in group' do
        person.stub(member_of?: true)
        subject.should be_false
      end
    end
  end

  describe 'show_group_member_buttons?' do

    subject do
      helper.show_group_member_buttons? person, group
    end

    let(:group) { double }

    context 'person is nil' do

      let(:person) { nil }

      it 'is false' do
        subject.should be_false
      end
    end

    context 'person is not nil' do

      let(:person) { double }

      it 'is false when person is not in group' do
        person.stub(member_of?: false)
        subject.should be_false
      end

      it 'is true when person is in group' do
        person.stub(member_of?: true)
        subject.should be_true
      end
    end
  end
end
