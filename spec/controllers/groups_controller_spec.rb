require 'spec_helper'

describe GroupsController do

  describe 'create' do
    let(:person) { create(:person) }

    context 'with correct params' do
      let(:params) {{ group: { name: 'rubycorns', email: 'test@tehest.com', contact: 'fruitcakes', city: 'Berlin', country: 'DE' } }}

      before do
        allow(controller).to receive :authenticate_person!
      end

      it 'creates a new group' do
        expect do
          post :create, params
        end.to change{ Group.count }.by(1)
      end

      it 'redirects to the group show page' do
        post :create, params
        expect(response).to redirect_to group_path(Group.first)
      end
    end

    context 'with incorrect params' do

      let(:params) {{group: { name: ''}}}

      before do
        allow(controller).to receive :authenticate_person!
      end

      it 'redirects to the sign in path' do
        post :create, params
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'update' do
    let(:group) { create(:group) }
    let(:person) { create(:person) }
    let(:params) { {group: { name: 'Changed group name'},
                id: group.id} }

    before do
      allow(controller).to receive :authenticate_person!
      allow(controller).to receive(:current_person).and_return(person)
      allow(Group).to receive(:find).and_return(group)

    end

    context 'as a member of the group' do
      before do
        person.join!(group)
      end

      it 'updates the group' do
        expect do
          put :update, params
        end.not_to change{ Group.count }
      end

      it 'updates the name of the group' do
        put :update, params
        expect(Group.find_by(name: 'Changed group name')).to_not be nil
      end

      it 'redirects to the groups overview' do
        put :update, params
        expect(response).to redirect_to group_path(group)
      end

      it 'displays the correct notice' do
        put :update, params
        expect(flash[:notice]).to match /updated/
      end
    end

    context 'as a non-member of the group' do

      it 'does not update the name of the group' do
        put :update, params
        expect(group.name).to eq 'Test Group'
      end

      it 'redirects to the groups overview' do
        put :update, params
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
        delete :destroy, id: group.id
        expect(response.status).to eq 403
      end

      it 'does not delete the group' do
        expect do
            delete :destroy, id: group.id
          end.not_to change { Group.count }
      end
    end

    context 'as an admin' do

      before do
        person.admin = true
      end

      it 'redirects to the groups path after successful deletion' do
        delete :destroy, id: group.id
        expect(response).to redirect_to groups_path
      end

      it 'displays the correct notice' do
        delete :destroy, id: group.id
        expect(flash[:notice]).to match /success/
      end

      it 'deletes the group' do
        expect do
            delete :destroy, id: group.id
          end.to change{ Group.count }.by(-1)
      end
    end
  end
end
