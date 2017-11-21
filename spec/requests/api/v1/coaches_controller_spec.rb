require "spec_helper"

RSpec.describe Api::V1::CoachesController, type: :request do
  let!(:coaches) { FactoryGirl.create_list(:workshop_coach, 10) }

  describe '#index' do
    before { get '/api/v1/coaches', headers: { 'Accept': 'application/json' } }

    it 'returns HTTP status 200' do
      expect(response).to have_http_status 200
    end

    it 'returns all coaches' do
      body = JSON.parse(response.body)
      expect(body.size).to eq(10)
    end

    it 'returns only the allowed attributes' do
      body = JSON.parse(response.body)
      expect(body.first.keys).to match_array ['first_name', 'last_name', 'groups']
    end
  end
end
