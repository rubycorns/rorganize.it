require 'spec_helper'

feature 'create a group' do

  before { visit new_person_session_path }
  before { sign_in person }

  let(:person) { create(:person) }

  scenario 'create a group and be a member of it' do
    visit root_path
    click_link 'Groups'
    click_link 'register new group'
    fill_in 'Project group name', with: 'Testgroup'
    fill_in 'Where we\'ll send official emails', with: 'test@email.com'
    fill_in 'Contact info', with: 'this googlegroup'
    expect(page).to have_content('Join group as coach')
    check 'Join group as coach'
    expect(page).to_not have_content('Is your group full?')
    click_button 'Create Group'

    expect(page).to have_content('Group was successfully created.')

    within('.page-header') do
      expect(page).to have_content('Testgroup')
    end
    within('.group-info') do
      expect(page).to have_content(person.first_name)
    end

    expect(page).to have_content('This group currently has 0 students.')
    expect(page).to have_content('This group currently has 1 coach.')
  end

  scenario 'create a group and don\'t become a member of it' do
    visit root_path
    click_link 'Groups'
    click_link 'register new group'
    fill_in 'Project group name', with: 'Testgroup'
    fill_in 'Where we\'ll send official emails', with: 'test@email.com'
    fill_in 'Contact info', with: 'this googlegroup'
    expect(page).to have_content('Join group as coach')
    click_button 'Create Group'

    expect(page).to have_content('Group was successfully created.')

    within('.page-header') do
      expect(page).to have_content('Testgroup')
    end
    within('.group-info') do
      expect(page).to_not have_content(person.first_name)
    end

    expect(page).to have_content('This group currently has 0 students.')
    expect(page).to have_content('This group currently has 0 coaches.')
  end

end