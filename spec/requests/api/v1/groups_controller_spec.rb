require "spec_helper"

RSpec.describe Api::V1::GroupsController, type: :request do
  let!(:groups) { FactoryGirl.create_list(:group, 10) }

  describe '#index' do
    before { get '/api/v1/groups', headers: { 'Accept': 'application/json' } }

    it 'returns HTTP status 200' do
      expect(response).to have_http_status 200
    end

    it 'returns all groups' do
      body = JSON.parse(response.body)
      expect(body.size).to eq(10)
    end

    it 'returns only the allowed attributes' do
      body = JSON.parse(response.body)
      expect(body.first.keys).to match_array ['name', 'address', 'street',
                                              'zip', 'city', 'country', 'time',
                                              'twitter', 'level', 'inactive',
                                              'allow_male_students',
                                              'students_count', 'coaches_count']
    end
  end

  describe '#show' do
    let(:group) { create :group }
    let(:person) { create :person }

    before do
      person.join!(group, {})
      get "/api/v1/groups/#{group.id}", headers: { 'Accept': 'application/json '}
    end

    it 'returns HTTP status 200' do
      expect(response).to have_http_status 200
    end

    it 'returns a single group' do
      body = JSON.parse(response.body)
      expect(request.path).to eql "/api/v1/groups/#{group.id}"

      expect(body["name"]).to eql(group.name)
      expect(body["students_count"]).to eql(1)
    end
  end
end
