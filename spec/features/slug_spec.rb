require 'spec_helper'

feature 'slugs' do

  before { visit new_person_session_path }

  let(:person) { create(:person) }
  let!(:group) { create(:group) }


  it 'slug something' do
  	user_visits_groups_slug
    group_name_is_visible
  end

  def user_visits_groups_slug
    visit groups_path
  end
end