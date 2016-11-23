require 'spec_helper'

feature 'update password' do

  before do
    visit new_person_session_path
    sign_in person
  end

  let(:person) { create(:person, password: 'password') }

  scenario 'update password' do
    visit person_path(person, redesign: true)
    click_on 'Change password'
    fill_in 'Current password', with: 'password'
    fill_in 'Password', with: 'test1234'
    fill_in 'Password confirmation', with: 'test1234'
    click_on 'Update'

    expect(page).to have_content 'You updated your account successfully'
    click_on 'logout'

    visit person_session_path
    fill_in 'Email', with: person.email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
    expect(page).to have_content 'Invalid email or password'

    fill_in 'Email', with: person.email
    fill_in 'Password', with: 'test1234'
    click_button 'Sign in'
    expect(page).to have_content 'Signed in successfully'
  end
end
