require 'spec_helper'

describe AdminsController do

  let(:person) { create :person }
  let(:admin) { create :admin }
  before :each do
    allow(controller).to receive :authenticate_person!
    allow(controller).to receive(:current_person).and_return(admin)
  end

  describe 'create' do

    it 'is not allowed for normal users' do
      post :create, id: person.id
      expect(person.admin?).to be false
    end

    it 'gives admin powers to an admin user' do
      post :create, id: admin.id
      expect(admin.admin?).to be true
    end
  end

  describe 'destroy' do

    it 'removes admin power from a user' do
      delete :destroy, id: admin.id
      expect(admin.reload.admin?).to be false
    end
  end

end
