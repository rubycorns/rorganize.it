require 'spec_helper'

describe GroupsHelper, :type => :helper do

  describe 'show_join_group_button?' do

    subject do
      helper.show_join_group_button? person, group
    end

    let(:group) { double }

    context 'person is nil' do

      let(:person) { nil }

      it 'is true' do
        expect(subject).to be_truthy
      end
    end

    context 'person is not nil' do

      let(:person) { double }

      it 'is true when person is not in group' do
        allow(person).to receive_messages(member_of?: false)
        expect(subject).to be_truthy
      end

      it 'is false when person is in group' do
        allow(person).to receive_messages(member_of?: true)
        expect(subject).to be_falsey
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
        expect(subject).to be_falsey
      end
    end

    context 'person is not nil' do

      let(:person) { double }

      it 'is false when person is not in group' do
        allow(person).to receive_messages(member_of?: false)
        expect(subject).to be_falsey
      end

      it 'is true when person is in group' do
        allow(person).to receive_messages(member_of?: true)
        expect(subject).to be_truthy
      end
    end
  end
end
