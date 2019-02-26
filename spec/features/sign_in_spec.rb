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

  context 'with the incorrect information' do
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

  context 'with github' do

    before(:each) do
      # https://github.com/intridea/omniauth/wiki/Integration-Testing#omniauthconfigadd_mock
      OmniAuth.config.test_mode = true

      OmniAuth.config.add_mock(:github,
        provider: "github",
        uid: "1234567",
        info: {
          nickname: "Willow",
          email: "willow.rosenberg@example.com",
          name: "Willow Rosenberg",
          image: ""
        }
      )
    end

    before do
      visit root_path
      click_link "Sign in with GitHub"
    end

    it 'successfully signs in the user via github' do
      expect(page).to have_content("Successfully authenticated from GitHub account")
    end
  end

  context 'merging an account with github' do
    let!(:person) { create(:person, email: 'cordelia.chase@example.com', first_name: 'Cordelia', provider: nil) }

    before(:each) do
      OmniAuth.config.test_mode = true

      OmniAuth.config.add_mock(:github,
        provider: "github",
        uid: "7654321",
        info: {
          nickname: "Cordelia",
          email: "cordelia.chase@example.com",
          name: "Cordelia Chase",
          image: ""
        }
      )
    end

    it 'successfully merges the users account with github' do
      sign_in person
      visit person_path(person)

      click_link('Edit profile')
      find("#github-button").click

      expect(page).to have_content("Successfully authenticated from GitHub account")

      click_link('Edit profile')
      expect(page).to_not have_content("Link account with GitHub")
      expect(page).to have_content("Your account is linked to GitHub")
    end
  end
end
