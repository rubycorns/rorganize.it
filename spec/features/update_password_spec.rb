require 'spec_helper'

feature 'update password' do

  before { visit new_person_session_path }
  before { sign_in person }

  let(:person) { create(:person, password: 'password') }

  scenario 'update password' do
    visit person_path(person, redesign: true)
    click_on 'Change password'
    fill_in 'Current password', with: 'password'
    fill_in 'Password', with: 'test1234'
    fill_in 'Password confirmation', with: 'test1234'
    click_on 'Update'
    expect(page).to have_content 'You updated your account successfully'
  end
end
