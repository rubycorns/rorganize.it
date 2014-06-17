require 'spec_helper'

describe GroupsController do

  describe 'create' do
    let(:person) { create(:person) }

    context 'with correct params' do
      let(:params) {{ group: { name: 'rubycorns' } }}

      before do
        controller.stub :authenticate_person!
      end

      it 'creates a new group' do
        expect do
          post :create, params
        end.to change{ Group.count }.by(1)
      end

      it 'redirects to the root path' do
        post :create, params
        response.should redirect_to root_path
      end
    end

    context 'with incorrect params' do

      let(:params) {{group: { name: ''}}}

      before do
        controller.stub :authenticate_person!
      end

      it 'redirects to the sign in path' do
        post :create, params
        response.should render_template(:new)
      end
    end
  end

  describe 'edit' do

    let(:group) { create(:group) }
    let(:person) { create(:person) }

    before do
      controller.stub :authenticate_person!
      controller.stub(:current_person).and_return(person)
      Group.stub(:find).and_return(group)
    end

    it 'restricts access if editable is false' do
      group.stub(:is_editable_by?).with(person).and_return(false)
      get :edit, id: 1
      expect(response).to be_redirect
    end

    it 'allows access if editable is true' do
      group.stub(:is_editable_by?).with(person).and_return(true)
      get :edit, id: 1
      expect { get :edit }.to render_template(:edit)
    end
  end

  describe 'update' do
    let(:group) { create(:group) }
    let(:person) { create(:person) }

    before do
      controller.stub :authenticate_person!
      controller.stub(:current_person).and_return(person)
      Group.stub(:find).and_return(group)
      @params = { group: { name: 'Changed group name'},
                  id: group.id }
    end

    it 'updates the group' do
      expect do
        put :update, @params
      end.not_to change{ Group.count }
    end

    it 'updates the name of the group' do
      put :update, @params
      expect(group.name).to eq 'Changed group name'
    end

    it 'redirects to the groups path' do
      put :update, @params
      expect(response).to redirect_to groups_path
    end

    it 'displays the correct notice' do
      put :update, @params
      flash[:notice].should_not be_blank
    end
  end

  describe 'destroy' do
    let(:group) { create(:group) }
    let(:person) { create(:person) }

    before do
      controller.stub :authenticate_person!
      controller.stub(:current_person).and_return(person)
      Group.stub(:find).and_return(group)
    end

    it 'redirects to the groups path after deleting a group' do
      delete :destroy, id: group.id
      expect(response).to redirect_to groups_path
    end

    it 'displays the correct notice' do
      delete :destroy, id: group.id
      flash[:notice].should_not be_blank
    end

    it 'deletes the group' do
      expect do
          delete :destroy, id: group.id
        end.to change{ Group.count }.by(-1)
    end
  end
end
