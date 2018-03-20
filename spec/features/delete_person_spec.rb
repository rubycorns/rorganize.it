
require 'spec_helper'

describe 'deleting a user as a signed in user', :type => :feature do
  subject { page }
  before { visit new_person_session_path }

  let(:person) { create(:person) }
  let(:second_person) { create(:second_person)}

  context 'on own profile page' do

    before do
      sign_in person
      visit person_path(person)
    end

    it "displays a delete button on the current_user's profile page" do
      expect(page).to have_content 'Delete account'
    end

    context 'deleting the current_user' do
      before do
        click_link 'Delete account'
      end

      it "allows a user to delete themselves" do
        expect { person.reload }.to raise_error ActiveRecord::RecordNotFound
      end

      it "redirects the user to the root page" do
        expect(current_path).to eq(root_path)
      end

      it 'displays the correct error message' do
        expect(page.text).to match(/success/)
      end
    end
  end

  context "on someone else's profile page" do

    before do
      sign_in second_person
      visit person_path(person)
    end

    it "a display button is not be present" do
      expect(page).not_to have_content 'Delete account'
    end
  end
end
