require 'spec_helper'

describe MembershipsController, :vcr => {:cassette_name => "create_group" } do
  let!(:person) { create(:person) }
  let(:group) { create(:group) }

  before do
    allow(controller).to receive :authenticate_person!
    allow(controller).to receive(:current_person).and_return(person)
    @params = { membership:
      { group_id: group.id,
        type: 'StudentMembership'
      }
    }
  end

  describe 'create' do


    it 'creates a membership' do
      expect do
        post :create, @params
      end.to change{ Membership.count}.by(1)
    end

    it 'sends an email to the group' do
      expect do
        post :create, @params
      end.to change { ActionMailer::Base.deliveries.size }.by(1)
    end

    it 'renders the correct message' do
      post :create, @params
      expect(flash[:success]).not_to be_blank
    end

    it 'redirects to the group path' do
      post :create, @params
      expect(response).to redirect_to group_path(group)
    end
  end

  describe 'destroy' do

    before do
      person.join!(group)
      @membership = person.memberships.first
    end

    it 'redirects to the groups path after leaving a group' do
      delete :destroy, id: @membership.id
      expect(response).to redirect_to groups_path
    end

    it 'deletes the membership' do
      expect do
        delete :destroy, id: @membership.id
      end.to change{ Membership.count }.by(-1)
    end

    it 'displays the correct notice' do
      delete :destroy, id: @membership.id
      expect(flash[:success]).not_to be_blank
    end
  end

  describe 'a full group' do
    let(:group) { create :group, full: true }

    it 'does allow a membership to be created' do
      expect do
        post :create, @params
      end.not_to change{ Membership.count}
    end
  end

end
