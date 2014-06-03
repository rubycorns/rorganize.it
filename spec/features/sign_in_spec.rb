require 'spec_helper'

describe 'Signing in' do
  subject { page }
  before { visit new_person_session_path }

  let(:person) { create(:person) }

  context 'with the correct information' do

    before do
      sign_in person
    end

    it 'should go to the main page' do
      current_path.should == root_path
    end

    it 'should display the correct alert message' do
      page.should have_content 'Signed in successfully'
    end
  end

  describe 'with the incorrect information' do
    before do
      fill_in 'Email', with: person.email
      fill_in 'Password', with: 'wrongpassword'
      click_button 'Sign in'
    end

    it 'should not sign in the person' do
      current_path.should == new_person_session_path
    end

    it 'should display the correct alert message' do
      page.should have_content 'Invalid email or password'
    end
  end
end