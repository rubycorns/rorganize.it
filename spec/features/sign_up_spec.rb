require 'spec_helper'

describe 'Signing up', :type => :feature do
  before { visit new_person_registration_path }

  context 'with all required info' do
    before do
      fill_in 'First name',            with: 'Ruby'
      fill_in 'Last name',             with: 'Corn'
      fill_in 'E-mail',                with: 'ruby.corn@example.org'
      fill_in 'Password',              with: 'supersecret123'
      fill_in 'Password Confirmation', with: 'supersecret123'
      click_button 'Save'
    end

    it 'creates a user' do
      expect(page).to have_content("Welcome! You have signed up successfully.")
      expect(current_path).to eql '/welcome'
      expect(Person.last.first_name).to eql 'Ruby'
    end
  end
end