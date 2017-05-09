require 'spec_helper'

feature 'edit a group', vcr: {cassette_name: 'create_group'} do
  before do
    visit new_person_session_path
    sign_in person
  end

  context 'as an admin member of a group' do
    let(:person) { create(:person) }
    let(:group) { create(:group) }

    before { person.join!(group, {admin: true}) }

    scenario 'edit the name of an existing group' do
      visit_group_edit_page_as_a_member
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
      expect(page).to have_content('Inactive')
      visit_group_edit_page_as_a_member
      check 'Is your group full?'
      click_button 'Update Group'
      expect(page).to have_content('Inactive')
    end

    scenario 'allow male students' do
      visit_group_edit_page_as_a_member
      check 'Do you welcome male students?'
      click_button 'Update Group'
      expect(page).to have_content('Mixed group')
    end

    def visit_group_edit_page_as_a_member
      visit root_path
      click_link 'Groups'
      click_link group.name
      expect(page).to have_content('Edit')
      click_link 'Edit group'
      expect(page).to have_content('Group name')
    end
  end

  context 'as a non member of a group' do
    let(:person) { create :person }
    let!(:group) { create(:group) }

    scenario 'edit the name of an existing group' do
      visit root_path
      click_link 'Groups'
      click_link group.name
      expect(page).to_not have_content 'Edit group'
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
      expect(page).to have_content('Edit as admin')
      click_link 'Edit as admin'
      expect(page).to have_content('Group name')
    end
  end
end
