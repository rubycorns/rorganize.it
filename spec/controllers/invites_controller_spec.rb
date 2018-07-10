require 'rails_helper'

RSpec.describe InvitesController, { type: :controller,
                                    vcr: { cassette_name: 'create_group' } } do
  let!(:person) { create(:person) }
  let!(:group) { create(:group) }

  let(:params) { { invite: { group_id: group.id,
                             person_id: person.id }}}

  before do
    allow(controller).to receive :authenticate_person!
    allow(controller).to receive(:current_person).and_return(person)
  end

  describe '#create' do
    it 'creates an invite' do
      expect do
        post :create, params: params
      end.to change { Invite.count }.by 1
    end
    it 'redirects to' do
      post :create, params: params
      expect(response).to redirect_to group_path(group)
    end

    it 'sends an email to the group' do
      expect do
        post :create, params: params
      end.to change { ActionMailer::Base.deliveries.size }.by 1
    end

    it 'renders flash message' do
      post :create, params: params
      expect(flash[:notice]).not_to be_blank
    end
  end

  describe '#destroy' do
    shared_examples_for "destroy invite" do
      it 'redirects to group path' do
        delete :destroy, params: { id: invite.id, invite: { state: 'true' }}
        expect(response).to redirect_to group_path(group)
      end

      it 'sends an email' do
        expect do
          delete :destroy, params: { id: invite.id, invite: { state: 'true' }}
        end.to change { ActionMailer::Base.deliveries.size }.by 1
      end

      it 'destroys an invite' do
        expect do
          delete :destroy, params: { id: invite.id, invite: { state: 'true' }}
        end.to change { Invite.count }.by -1
      end
    end


    context 'accept invite' do
      let(:invite) { person.invites.first }

      before do
        Invite.new(person_id: person.id,
                   group_id: group.id).save!
      end

      it 'renders the flash message' do
        delete :destroy, params: { id: invite.id, invite: { state: 'true' }}
        expect(flash[:notice]).to have_content('New member accepted')
      end

      it 'increases membership count' do
        expect do
          delete :destroy, params: { id: invite.id, invite: { state: 'true' }}
        end.to change { Membership.count }.by 1
      end

      include_examples "destroy invite"
    end

    context 'decline invite' do
      let(:invite) { person.invites.first }

      before do
        Invite.new(person_id: person.id,
                   group_id: group.id).save!
      end

      it 'renders the flash message' do
        delete :destroy, params: { id: invite.id, invite: { state: 'false' }}
        expect(flash[:notice]).to have_content('Rejection successful')
      end

      it 'does not increase membership count' do
        expect do
          delete :destroy, params: { id: invite.id, invite: { state: 'false' }}
        end.to_not change { Membership.count }
      end

      include_examples "destroy invite"
    end
  end
end
