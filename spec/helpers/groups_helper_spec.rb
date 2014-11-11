require 'spec_helper'

describe GroupsHelper do

  describe 'show_join_group_button?' do

    subject do
      helper.show_join_group_button? person, group
    end

    let(:group) { double }

    context 'person is signed in' do
      before do
        allow(helper).to receive_messages(person_signed_in?: true)
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
        allow(helper).to receive_messages(person_signed_in?: false)
      end

      let(:person) { nil }

      it 'shows the button' do
        expect(subject).to be true
      end
    end
  end

  describe '#even_a_button?' do
    context 'group is not full' do
      let(:group) { double(full?: false) }

      it 'shows the button' do
        expect(helper.even_a_button?(group)).to be true
      end
    end

    context 'group is full' do
      let(:group) { double(full?: true) }

      it 'does not show the button' do
        expect(helper.even_a_button?(group)).to be false
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
        allow(helper).to receive_messages(person_signed_in?: false)
      end

      let(:person) { nil }

      it 'is false' do
        expect(subject).to be_falsey
      end
    end

    context 'person is signed in' do

      before do
        allow(helper).to receive_messages(person_signed_in?: true)
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
end
