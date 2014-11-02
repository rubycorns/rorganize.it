require 'spec_helper'

describe GroupsHelper do

  describe 'show_join_group_button?' do

    subject do
      helper.show_join_group_button? person, group
    end

    let(:group) { double }

    context 'person is not signed in' do

      let(:person) { nil }

      it 'is true' do
        expect(subject).to be_truthy
      end
    end

    context 'person is signed in' do

      let(:person) { double }

      before do
        allow(person).to receive_messages(member_of?: false)
        allow(group).to receive_messages(closed?: false)
      end

      it 'displays buttons when person is not in group & when group is open' do
        expect(subject).to be_truthy
      end

      it 'does not display buttons when person is in group & when group is open' do
        allow(person).to receive_messages(member_of?: true)
        expect(subject).to be_falsey
      end

      it 'does not display buttons when group is closed' do
        allow(group).to receive_messages(closed?: true)
        expect(subject).to be_falsey
      end
    end
  end

  describe 'show_member_buttons?' do

    subject do
      helper.show_member_buttons? person, group
    end

    let(:group) { double }

    context 'person is not signed in' do

      let(:person) { nil }

      it 'is false' do
        expect(subject).to be_falsey
      end
    end

    context 'person is signed in' do

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
