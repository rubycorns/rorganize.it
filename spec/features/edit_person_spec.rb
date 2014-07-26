require 'spec_helper'

feature 'edit a person' do

  before { visit new_person_session_path }
  before { sign_in person }

  let(:person) { create(:person) }

  scenario 'the working on section ' do
    visit person_path(person)
    click_link 'edit'
    expect(page).to have_content('Edit Account')
    fill_in "working-on", with: 'stuff'
    expect(page).to have_button('Save')
    click_button 'Save'
  end

  it 'displays a successful alert message' do
    expect(page.text).to have_content "You updated your account successfully"
  end

  it 'redirects to the correct path' do
  end
end
