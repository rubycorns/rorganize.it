require 'spec_helper'

feature 'edit a group', :vcr => {:cassette_name => "create_group" } do

  before { visit new_person_session_path }
  before { sign_in person }

  let(:person) { create(:person) }
  let(:group) { create(:group) }

  before { person.join!(group, 'StudentMembership') }

  scenario 'edit the name of an existing group' do
    visit_group_edit_page
    expect(page).to_not have_content('Join group as coach')
    fill_in 'Project group name', with: 'Testgroup'
    click_button 'Update Group'

    within('.page-header') do
      expect(page).to have_content('Testgroup')
    end
  end

  scenario 'edit the city and country of an existing group' do
    visit_group_edit_page
    fill_in 'City', with: 'Not Berlin'
    select 'France'
    click_button 'Update Group'

    expect(page).to have_content('Not Berlin, FR')
  end

  scenario 'make current group inactive' do
    visit_group_edit_page
    check 'Is your group inactive?'
    click_button 'Update Group'
    expect(page).to have_content('GROUP CURRENTLY INACTIVE')
    visit_group_edit_page
    check 'Is your group full?'
    click_button 'Update Group'
    expect(page).to have_content('GROUP CURRENTLY INACTIVE')
  end

  def visit_group_edit_page
    visit root_path
    click_link 'Groups'
    expect(page).to have_content('edit')
    click_link 'edit'
    expect(page).to have_content('Project group name')
  end

end
