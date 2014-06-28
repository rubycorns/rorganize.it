require 'spec_helper'

describe 'deleting a user as a signed in user' do
  subject { page }
  before { visit new_person_session_path }

  let(:person) { create(:person) }
  let(:second_person) { create(:second_person)}

  context 'on own profile page' do

    before do
      sign_in person
      visit person_path(person)
    end

    it "should display a delete button on the current_user's profile page" do
      page.should have_content 'delete'
    end

    context 'deleting the current_user' do
      before do
        click_link 'delete'
      end

      it "should allow a user to delete themselves" do
        expect { person.reload }.to raise_error ActiveRecord::RecordNotFound
      end

      it "should redirect the user to the root page" do
        current_path.should == root_path
      end

      it 'should display the correct error message' do
        expect(page.text).to match(/success/)
      end
    end
  end

  context "on someone else's profile page" do

    before do
      sign_in second_person
      visit person_path(person)
    end

    it "a display button should not be present" do
      page.should_not have_content 'delete'
    end
  end
end
