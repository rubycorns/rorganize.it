require 'spec_helper'

feature 'edit a person' do

  before { visit new_person_session_path }
  before { sign_in person }

  let(:person) { create(:person) }

  before do
    visit person_path(person)
    click_link 'edit'
    expect(page).to have_content('Your first name')
  end

  describe 'changing the working on section ' do

    before do
      fill_in "working-on", with: 'capybara, rspec, css'
      click_button 'Save'
    end

    it 'displays a successful alert message' do
      expect(page.text).to have_content "You updated your profile!"
    end

    it 'redirects to the correct path' do
      expect(current_path).to eq person_path(person)
    end

    it 'updates the correct information' do
      within('#working-on') do
        expect(page).to have_content 'capybara, rspec, css'
      end
    end

  end
end
