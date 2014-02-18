require 'spec_helper'

describe GroupsController do

  describe 'edit' do

    let(:group) do
      Group.new
    end

    let(:person) do
      Person.new
    end

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
      expect(response).to_not be_redirect
    end

  end

end