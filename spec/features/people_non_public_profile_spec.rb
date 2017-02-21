require 'spec_helper'

feature 'person profile visibility' do

  let(:person) { create(:person) }
  let(:person2) { create(:person) }

  scenario 'non public profile setting' do
    visit new_person_session_path
    sign_in person
    visit person_path(person)
    expect(page).to_not have_content('Your account is not public')

    click_link 'edit'
    check "Make my account not public"
    click_button 'Save'
    expect(page).to have_content('Your account is not public')

    click_link 'All'
    expect(page).to have_content('Ruby Corn')

    click_link 'logout'
    click_link 'All'
    expect(page).to_not have_content('Ruby Corn')

    visit new_person_session_path
    sign_in person2
    click_link 'All'
    expect(page).to have_content('Ruby Corn')

    person2.update_attribute(:admin, true)
    expect(page).to have_content('Ruby Corn')
  end
end

feature 'coaches list visibility' do
  let(:person) { create(:person) }

  scenario 'workshop coach non public setting' do
    visit new_person_session_path
    sign_in person
    visit edit_person_path(person)
    check 'I am willing to COACH at Rails Girls workshops'
    click_button 'Save'
    click_link 'logout'
    visit coaches_path
    expect(page).to have_content('Ruby Corn')

    visit new_person_session_path
    sign_in person
    visit edit_person_path(person)
    check "Make my account not public"
    click_button 'Save'
    click_link 'logout'
    visit coaches_path
    expect(page).to_not have_content('Ruby Corn')
  end
end
