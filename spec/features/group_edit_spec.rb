require 'spec_helper'

feature 'edit a group' do

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

  def visit_group_edit_page
    visit root_path
    click_link 'Groups'
    expect(page).to have_content('edit')
    click_link 'edit'
    expect(page).to have_content('Edit group')
  end

end