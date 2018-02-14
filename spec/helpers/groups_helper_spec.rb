
require 'spec_helper'

describe GroupsHelper do

  describe 'show_join_group_button?' do

    subject do
      helper.show_join_group_button? person, group
    end

    let(:group) { double }

    context 'person is signed in' do
      before do
        allow(helper).to receive(:logged_in?).with(person).and_return true
      end

      context 'person is not a member of the group' do
        let(:person) { double(member_of?: false) }

        it 'shows the button' do
          expect(subject).to be true
        end
      end

      context 'person is a member of the group' do
        let(:person) { double(member_of?: true) }

        it 'does not show the button' do
          expect(subject).to be false
        end
      end
    end

    context 'person is not signed in' do
      before do
        allow(helper).to receive(:logged_in?).with(person).and_return false
      end

      let(:person) { nil }

      it 'shows the button' do
        expect(subject).to be true
      end
    end
  end

  describe 'show_member_buttons?' do

    subject do
      helper.show_member_buttons? person, group
    end

    let(:group) { double }

    context 'person is not signed in' do

      before do
        allow(helper).to receive(:logged_in?).with(person).and_return false
      end

      let(:person) { nil }

      it 'is false' do
        expect(subject).to be_falsey
      end
    end

    context 'person is signed in' do

      before do
        allow(helper).to receive(:logged_in?).with(person).and_return true
      end

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

  describe '#group_location' do
    let(:group) { build_stubbed :group, city: 'Berlin', country: 'DE', street: 'Willy-Brandt-Straße 1', zip: '10557' }
    let(:group_empty) { build_stubbed :group, city: nil, country: nil }

    it 'returns a string with all relevant location info together' do
      expect(helper.group_location(group)).to eql 'Willy-Brandt-Straße 1, 10557, Berlin, Germany'
    end

    it 'does not complain if none of that info is present' do
      expect(helper.group_location(group_empty)).to eql ''
    end
  end
end
