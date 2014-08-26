require 'spec_helper'

describe AdminsController do

  let(:person) { create(:person) }
  let(:admin) { create(:second_person) }
  before :each do
    admin.add_role(:admin)
    admin.save
    allow(controller).to receive :authenticate_person!
    allow(controller).to receive(:current_person).and_return(admin)
  end

  describe 'create' do

    it 'gives admin powers to a user' do
      post :create, admin: person.id
      expect(person).to have_role(:admin)
    end
  end

  describe 'destroy' do

    it 'removes admin power from a user' do
      person.add_role(:admin)
      person.save
      delete :destroy, person: { admin_id: person.id }, id: person.id
      expect(person).to_not have_role(:admin)
    end
  end
end
