require 'spec_helper'

describe MembershipsController, vcr: {cassette_name: 'create_group'} do
  let!(:person) { create(:person) }
  let(:group) { create(:group) }
  let(:params) { { membership: { group_id: group.id, type: 'StudentMembership', admin: false }}}

  before do
    allow(controller).to receive :authenticate_person!
    allow(controller).to receive(:current_person).and_return(person)
  end

  describe 'create' do

    it 'creates a membership' do
      expect do
        post :create, params
      end.to change{ Membership.count}.by(1)
    end

    it 'sends an email to the group' do
      expect do
        post :create, params
      end.to change { ActionMailer::Base.deliveries.size }.by(1)
    end

    it 'renders the correct message' do
      post :create, params
      expect(flash[:success]).not_to be_blank
    end

    it 'redirects to the group path' do
      post :create, params
      expect(response).to redirect_to group_path(group)
    end
  end

  describe 'destroy' do

    context 'removing yourself from a group' do
      let(:membership) { person.memberships.first}

      before do
        person.join!(group, {})
      end

      it 'redirects to the groups path after leaving a group' do
        delete :destroy, id: membership.id
        expect(response).to redirect_to groups_path
      end

      it 'deletes the membership' do
        expect do
          delete :destroy, id: membership.id
        end.to change{ Membership.count }.by(-1)
      end

      it 'displays the correct notice' do
        delete :destroy, id: membership.id
        expect(flash[:success]).to have_content  "You have left your group. No doubt they will miss you. Please consider buying everyone cake on your last day."
      end
    end

    context 'removing someone else from a group' do
      let(:another_person) { create :person }
      let(:membership) { another_person.memberships.first}

      before do
        another_person.join!(group, {})
      end

      it 'deletes the membership' do
        expect do
          delete :destroy, id: membership.id
        end.to change{ Membership.count }.by(-1)
      end

      it 'displays the correct notice' do
        delete :destroy, id: membership.id
        expect(flash[:success]).to have_content "You have successfully deleted a person from the group. That was a very tough decision. Cake will make it all better."
      end
    end
  end

  describe 'a full group' do
    let(:group) { create :group, full: true }

    it 'does allow a membership to be created' do
      expect do
        post :create, params
      end.not_to change{ Membership.count}
    end
  end

end
