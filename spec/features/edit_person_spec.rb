
require 'spec_helper'

feature 'edit a person' do
  before do
    visit new_person_session_path
    sign_in person
  end

  let(:person) { create(:person) }

  before do
    visit person_path(person)
    click_link 'Edit profile'
    expect(page).to have_content('Your first name')
  end

  describe 'changing the working on section ' do
    before do
      fill_in "working-on", with: 'capybara, rspec, css'
      click_button 'Save'
    end

    scenario 'displays a successful alert message' do
      expect(page.text).to have_content "You updated your profile!"
    end

    scenario 'redirects to the correct path' do
      expect(current_path).to eq person_path(person)
    end

    scenario 'updates the correct information' do
      within('.working-on') do
        expect(page).to have_content 'capybara, rspec, css'
      end
    end

  end

  describe 'adding a valid personal website' do
    scenario 'with complete link' do
      fill_in "Your website", with: 'http://pragtob.info'
      click_button 'Save'
      expect(page).to have_content 'http://pragtob.info'
    end

    scenario 'with incomplete link' do
      fill_in "Your website", with: 'malweene.com'
      click_button 'Save'
      expect(page).to have_content 'http://malweene.com'
    end
  end

  scenario 'adding and removing a picture' do
    attach_file "Your profile picture",   Rails.root + "public/avatar.png"
    click_button 'Save'
    click_link 'Edit profile'
    within('.edit_person') do
      expect(page).to have_css '.profile-picture'
      expect(page).to have_content 'Remove profile picture'
    end
    check 'Remove profile picture'
    click_button 'Save'
    click_link 'Edit profile'
    within('.edit_person') do
      expect(page).to_not have_css '.profile-picture'
      expect(page).to_not have_content 'Remove profile picture'
    end
  end
end
