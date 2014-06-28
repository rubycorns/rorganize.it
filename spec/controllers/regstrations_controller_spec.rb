require 'spec_helper'

describe RegistrationsController do

  # see accepted answer from stackoverflow for an explanation
  # http://stackoverflow.com/questions/6659555/how-to-write-controller-tests-when-you-override-devise-registration-controller
  before :each do
    request.env['devise.mapping'] = Devise.mappings[:person]
  end

  let(:person) { create(:person) }

  describe 'destroy' do
    before do
      controller.stub :authenticate_person!
      controller.stub(:current_person).and_return(person)
    end

    it "deletes the user's account" do
      expect do
        delete :destroy, id: person.id
      end.to change{ Person.count }.by(-1)
    end

    it 'redirects to the root page' do
      delete :destroy, id: person.id
      expect(response).to redirect_to root_path
    end

    it 'displays the correct notice' do
      delete :destroy, id: person.id
      flash[:notice].should match /success/
    end
  end
end
