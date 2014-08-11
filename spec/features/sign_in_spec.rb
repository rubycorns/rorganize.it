require 'spec_helper'

describe 'Signing in', :type => :feature do
  subject { page }
  before { visit new_person_session_path }

  let(:person) { create(:person) }

  context 'with the correct information' do

    before do
      sign_in person
    end

    it 'goes to the main page' do
      expect(current_path).to eq(root_path)
    end

    it 'displays the correct alert message' do
      expect(page).to have_content 'Signed in successfully'
    end
  end

  describe 'with the incorrect information' do
    before do
      fill_in 'Email', with: person.email
      fill_in 'Password', with: 'wrongpassword'
      click_button 'Sign in'
    end

    it 'does not sign in the person' do
      expect(current_path).to eq(new_person_session_path)
    end

    it 'displays the correct alert message' do
      expect(page).to have_content 'Invalid email or password'
    end
  end
end
