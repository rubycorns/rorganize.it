require 'spec_helper'

feature 'Remove a person from a group', vcr: {cassette_name: 'create_group'} do

  let(:person) { create(:person) }
  let(:group) { create(:group) }

  before do
    visit new_person_session_path
    sign_in person
  end

  context 'the non-admin' do

    it 'cannot see the remove form' do
      person.join!(group, {})
      go_to_group_page
      expect(page).to_not have_selector('.remove-from-group')
    end

  end

  context 'the admin' do
    before do
      person.update_attribute(:admin, true)
      person.join!(group, {})
      go_to_group_page
    end

    it 'can see the remove form' do
      expect(page).to have_content "Remove from group"
    end

    it 'can remove the person' do
      click_button "Remove from group"
      expect(current_path).to eq('/groups')
      go_to_group_page
    end

  end

  def go_to_group_page
    visit '/groups/'
    click_link 'Test Group'
  end
end
