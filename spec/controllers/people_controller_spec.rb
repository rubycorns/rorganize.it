require 'spec_helper'

describe PeopleController do

  describe 'index' do
    let!(:person) { create(:person) }

    before :each do
      get :index
    end

    it 'is successful' do
      expect(response).to be_success
    end

    it 'has a list of people' do
      expect(assigns(:people)).to include person
    end
  end

  describe 'update' do

    context 'success' do
      let(:person) { create(:person) }
      let(:params) { { person: { first_name: 'Buffy', mastodon: 'seunadex' }, id: person.id } }

      before do
        allow(controller).to receive :authenticate_person!
        allow(controller).to receive(:current_person).and_return(person)
        allow(Person).to receive(:find).and_return(person)
      end

      it 'updates the person' do
        put :update, params: params
        person.reload
        expect(person.first_name).to eq 'Buffy'
        expect(person.mastodon).to eq 'seunadex'
      end

      it 'displays the correct notice' do
        put :update, params: params
        expect(flash[:notice]).to match /updated/
      end
    end

    context 'failure' do
      let(:person) { create(:person) }
      let(:params) { { person: { first_name: ''}, id: person.id } }

      before do
        allow(controller).to receive :authenticate_person!
        allow(controller).to receive(:current_person).and_return(person)
        allow(Person).to receive(:find).and_return(person)
      end

      it 'redirects to the new path' do
        put :update, params: params
        expect(response).to render_template(:edit)
      end
    end
  end
end