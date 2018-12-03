require 'spec_helper'

describe GroupsController, vcr: {cassette_name: 'create_group'} do

  describe 'create' do
    let(:person) { create(:person) }

    context 'with correct params' do
      let(:params) {{ group: { name: 'rubycorns', email: 'test@tehest.com', contact: 'fruitcakes', city: 'Berlin', country: 'DE' } }}

      before do
        allow(controller).to receive :authenticate_person!
        allow(controller).to receive(:current_person).and_return(person)
      end

      it 'creates a new group' do
        expect do
          post :create, params: params
        end.to change{ Group.count }.by(1)
      end

      it 'redirects to the group show page' do
        post :create, params: params
        expect(response).to redirect_to group_path(Group.first)
      end
    end

    context 'with incorrect params' do

      let(:params) {{group: { name: ''}}}

      before do
        allow(controller).to receive :authenticate_person!
      end

      it 'redirects to the sign in path' do
        post :create, params: params
        expect(response).to render_template(:new)
      end
    end

    context 'with params with spaces' do

      let(:params) {{ group: { name: 'rubycorns', email: '  test@tehest.com', contact: 'fruitcakes', city: '  Berlin ', country: ' DE' } }}

      before do
        allow(controller).to receive :authenticate_person!
        allow(controller).to receive(:current_person).and_return(person)
      end

      it 'trims params' do
        post :create, params: params
        group = Group.find_by(name: 'rubycorns')
        expect(group.city).to eq('Berlin')
        expect(group.email).to eq('test@tehest.com')
        expect(group.country).to eq('DE')
      end
    end
  end

  describe 'my_groups' do
    let(:person) { create(:person) }
    let(:group) { create(:group, name: 'Group 1')}

    before do
      allow(controller).to receive :authenticate_person!
      allow(controller).to receive(:current_person).and_return(person)
      person.join!(group, {})
    end

    it 'should return groups i belong to' do
      get :my_groups

      expect(response).to be_success
      expect(person.groups.first.name).to eq(group.name)
      expect(person.groups.count).to eq(1)
    end

  end

  describe 'update' do
    let(:group) { create(:group, name: 'Awesome Group') }
    let(:person) { create(:person) }
    let(:params) { {group: { name: 'Changed group name', mastodon: 'abijawara@mastodon.social'},
                id: group.id} }

    before do
      allow(controller).to receive :authenticate_person!
      allow(controller).to receive(:current_person).and_return(person)
      allow(Group).to receive(:find).and_return(group)
    end

    context 'as an admin member of the group' do
      before do
        person.join!(group, admin: true)
      end

      it 'updates the group' do
        expect do
          put :update, params: params
        end.not_to change{ Group.count }
      end

      it 'updates the name and mastodon handle of the group' do
        put :update, params: params
        group = Group.find_by(name: 'Changed group name')
        expect(group).to_not be nil
        expect(group.mastodon).to eq 'abijawara@mastodon.social'
      end

      it 'redirects to the groups overview' do
        put :update, params: params
        expect(response).to redirect_to group_path(group)
      end

      it 'displays the correct notice' do
        put :update, params: params
        expect(flash[:notice]).to match /updated/
      end
    end

    context 'as a non-member of the group' do

      it 'does not update the name of the group' do
        put :update, params: params
        expect(group.name).to eq 'Awesome Group'
      end

      it 'redirects to the groups overview' do
        put :update, params: params
        expect(response.status).to eq 403
      end
    end
  end

  describe 'destroy' do

    let(:group) { create(:group) }
    let(:person) { create(:person) }

    before do
      allow(controller).to receive :authenticate_person!
      allow(controller).to receive(:current_person).and_return(person)
      allow(Group).to receive(:find).and_return(group)
    end

    context 'as a non-admin' do

      it 'does not allow a non-admin to delete a group' do
        delete :destroy, params: { id: group.id }
        expect(response.status).to eq 403
      end

      it 'does not delete the group' do
        expect do
          delete :destroy, params: { id: group.id }
        end.not_to change { Group.count }
      end
    end

    context 'as an admin' do

      before do
        person.admin = true
      end

      it 'redirects to the groups path after successful deletion' do
        delete :destroy, params: { id: group.id }
        expect(response).to redirect_to groups_path
      end

      it 'displays the correct notice' do
        delete :destroy, params: { id: group.id }
        expect(flash[:notice]).to match /success/
      end

      it 'deletes the group' do
        expect do
          delete :destroy, params: { id: group.id }
        end.to change{ Group.count }.by(-1)
      end
    end
  end
end
