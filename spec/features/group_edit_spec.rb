require 'spec_helper'

feature 'edit a group', :vcr => {:cassette_name => "create_group" } do
  before do
    visit new_person_session_path
    sign_in person
  end

  context 'as a member of a group' do
    let(:person) { create(:person) }
    let(:group) { create(:group) }

    before { person.join!(group, 'StudentMembership') }

    scenario 'edit the name of an existing group' do
      visit_group_edit_page
      expect(page).to_not have_content('Join group as coach')
      fill_in 'Group name', with: 'Testgroup'
      click_button 'Update Group'

      within('.page-header') do
        expect(page).to have_content('Testgroup')
      end
    end

    scenario 'edit the city and country of an existing group' do
      visit_group_edit_page_as_a_member
      fill_in 'City', with: 'Not Berlin'
      select 'France'
      click_button 'Update Group'

      expect(page).to have_content('Not Berlin, France')
    end

    scenario 'make current group inactive' do
      visit_group_edit_page_as_a_member
      check 'Is your group inactive?'
      click_button 'Update Group'
      expect(page).to have_content('GROUP CURRENTLY INACTIVE')
      visit_group_edit_page_as_a_member
      check 'Is your group full?'
      click_button 'Update Group'
      expect(page).to have_content('GROUP CURRENTLY INACTIVE')
    end

    scenario 'allow male students' do
      visit_group_edit_page
      check 'Do you welcome male students?'
      click_button 'Update Group'
      expect(page).to have_content('mixed group')
    end

    def visit_group_edit_page_as_a_member
      visit root_path
      click_link 'Groups'
      expect(page).to have_content('edit')
      click_link 'edit'
      expect(page).to have_content('Group name')
    end

    def visit_group_edit_page
      visit root_path
      click_link 'Groups'
      expect(page).to have_content('edit')
      click_link 'edit'
      expect(page).to have_content('Group name')
    end
  end

  context 'as an admin' do
    let(:person) { create(:admin) }
    let!(:group) { create(:group, name: 'AWESOME GROUP') }

    scenario 'edit the group as an admin' do
      visit_group_edit_page_as_admin
    end

    def visit_group_edit_page_as_admin
      visit groups_path
      click_link 'AWESOME GROUP'
      expect(page).to have_content('EDIT AS ADMIN')
      click_link 'EDIT AS ADMIN'
      expect(page).to have_content('Group name')
    end
  end
end
