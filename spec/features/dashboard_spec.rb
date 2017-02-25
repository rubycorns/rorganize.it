require 'spec_helper'

describe 'Admin dashboard', :type => :feature do
  subject { page }

  context 'the user is not logged in' do

    it 'is not accessible' do
      visit '/dashboard'
      expect(page).to have_content 'You need to sign in'
    end
  end

  context 'the user is logged in but not as admin' do
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

  context 'the user is logged in as admin' do
    let!(:person) { create(:admin) }
    let!(:person2) { create(:person, first_name: 'Person', last_name: '2') }

    before do
      visit new_person_session_path
      sign_in person
    end

    it 'is accessible' do
      visit '/dashboard'
      expect(page).to have_content 'Admin dashboard'
    end

    it 'allows to add another admin' do
      visit '/dashboard'

      within '.dashboard-admins' do
        select 'Person 2'
        click_button 'adminify'
      end
      within '.dashboard-admins' do
        expect(page).to have_selector 'li a', text: 'Person 2'
      end
      expect(page).to have_content 'Successfully adminified Person 2'
    end

    it 'allows to remove another admin' do

      visit '/dashboard'
      within '.dashboard-admins' do
        select 'Person 2'
        click_button 'adminify'
      end

      within "form#edit_person_#{person2.id}" do
        click_button 'un-adminify'
      end

      within '.dashboard-admins' do
        expect(page).to_not have_selector 'li a', text: 'Person 2'
      end
      expect(page).to have_content 'Successfully un-adminified Person 2'
    end
  end
end
