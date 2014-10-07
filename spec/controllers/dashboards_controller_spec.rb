require 'spec_helper'

describe DashboardsController do

  before :each do
    create(:person, first_name: 'D', last_name: 'Koernchen')
    create(:person, first_name: 'B', last_name: 'Hoernchen')
    create(:person, first_name: 'D', last_name: 'Hoernchen')
    create(:admin, first_name: 'C', last_name: 'Hoernchen')
    create(:admin, first_name: 'A', last_name: 'Hoernchen')
    allow(controller).to receive :authenticate_person!
    allow(controller).to receive :ensure_admin_powers
  end

  describe 'show' do
    it 'sorts admins and non-admins alphabetically' do
      get :show
      expect(assigns(:non_admins).map(&:to_s))
        .to eq(["B Hoernchen", "D Hoernchen", "D Koernchen"])
      expect(assigns(:admins).map(&:to_s))
        .to eq(["A Hoernchen", "C Hoernchen"])
    end
  end

end
