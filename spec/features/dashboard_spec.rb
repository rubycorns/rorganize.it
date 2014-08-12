require 'spec_helper'

describe 'Admin dashboard', :type => :feature do
  subject { page }

  context 'the user is not logged in' do
    
    it 'is not accessible' do
      visit '/dashboard'
      expect(page).to have_content 'You need to sign in'
    end
  end

  context 'the user logged in but not as admin' do

    let(:person) { create(:person) }

    before do
      visit new_person_session_path
      sign_in person
    end

    it 'is not accessible' do
      visit '/dashboard'
      expect(page).to have_content 'You shall not pass'
    end
  end
end
