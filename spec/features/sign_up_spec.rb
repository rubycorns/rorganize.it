
require 'spec_helper'

describe 'Signing up', :type => :feature do
  before { visit new_person_registration_path }

  it 'initially focuses first form input field' do
    expect(first('input[type="text"]')['autofocus']).to eql 'autofocus'
  end

  context 'with all required info' do
    before do
      fill_in 'First name',       with: 'Ruby'
      fill_in 'Last name',        with: 'Corn'
      fill_in 'email@email.com',  with: 'ruby.corn@example.org'
      fill_in 'Password',         with: 'supersecret123'
      fill_in 'Confirm password', with: 'supersecret123'
      click_button 'Sign up'
    end

    it 'creates a user' do
      expect(page).to have_content("Welcome! You have signed up successfully.")
      expect(current_path).to eql '/welcome'
      expect(Person.last.first_name).to eql 'Ruby'
    end
  end
end
