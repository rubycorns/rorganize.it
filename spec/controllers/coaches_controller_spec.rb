require 'spec_helper'

describe CoachesController do

  describe 'index' do
    let!(:coach) { create :person, first_name: 'Corn', workshop_coach: true }

    before :each do
      get :index
    end

    it 'is successful' do
      expect(response).to be_success
    end

    it 'has a list of people' do
      expect(assigns(:paginated_coaches)).to include coach
    end

    it 'has a list of people grouped alphabetically' do
      expect(assigns(:alphabetically_grouped_coaches)).to eql({'C' => [coach] })
    end

    it 'has a paginated list of alphabet keys' do
      expect(assigns(:paginated_alphabetical_list)).to eql ['C']
    end

    it 'has a list of all alphabet keys for all people' do
      expect(assigns(:total_alphabetical_list)).to eql ['C']
    end
  end
end