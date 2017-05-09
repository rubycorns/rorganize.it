require 'spec_helper'

feature 'create a group', vcr: {cassette_name: 'create_group'} do

  before do
    visit new_person_session_path
    sign_in person
  end

  let(:person) { create(:person) }

  scenario 'create a group and be a coach member of it' do
    visit root_path
    click_link 'Groups'
    click_link 'Register new group'
    fill_in 'Group name', with: 'Testgroup'
    fill_in 'Where we\'ll send automated emails to *', with: 'test@email.com'
    fill_in 'Group contact info', with: 'this googlegroup'
    fill_in 'City', with: 'Berlin'
    select('Germany', from: 'Country', match: :first) # selects the first Germany from dropdown (there are two b/c one is a preferred country at the top)
    expect(page).to have_content('Join group as coach')
    check 'Join group as coach'
    expect(page).to_not have_content('Is your group full?')
    click_button 'Create Group'

    expect(page).to have_content('Group was successfully created.')

    within('.page-header') do
      expect(page).to have_content('Testgroup')
    end
    within('#members') do
      expect(page).to have_content(person.first_name)
    end

    expect(page).to have_content('This group currently has 0 students.')
    expect(page).to have_content('This group currently has 1 coach.')
  end


  scenario 'create a group and be a coach member of it' do
    visit root_path
    click_link 'Groups'
    click_link 'Register new group'
    fill_in 'Group name', with: 'Testgroup'
    fill_in 'Where we\'ll send automated emails to *', with: 'test@email.com'
    fill_in 'Group contact info', with: 'this googlegroup'
    fill_in 'City', with: 'Berlin'
    select('Germany', from: 'Country', match: :first)
    click_button 'Create Group'

    expect(page).to have_content('Group was successfully created.')

    within('.page-header') do
      expect(page).to have_content('Testgroup')
    end
    within('#members') do
      expect(page).to have_content(person.first_name)
    end

    expect(page).to have_content('This group currently has 1 student.')
    expect(page).to have_content('This group currently has 0 coaches.')
  end

end
