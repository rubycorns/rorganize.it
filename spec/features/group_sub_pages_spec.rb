require 'spec_helper'

feature 'Explore group sub pages', vcr: {cassette_name: 'create_group'} do

  context 'as not logged in user' do
    let!(:group) { create(:group, {full: true, created_at: 8.month.ago}) }
    let!(:group2) { create(:group, {inactive: true}) }
    let!(:group3) { create(:group, {searching_students: true}) }

    scenario 'Find all groups on index page' do
      visit_group_main_page
      expect(find('ul.list-group')).to have_selector('li', count: 2)
    end

    scenario 'Find open groups' do
      visit_group_main_page
      click_link 'Open groups'
      expect(find('ul.list-group')).to have_selector('li', count: 2)
    end

    scenario 'Find groups searching for something' do
      visit_group_main_page
      click_link 'Groups searching'
      expect(find('ul.list-group')).to have_selector('li', count: 1)
    end

    scenario 'Find groups added in the last 6 months' do
      visit_group_main_page
      click_link 'Recently added'
      expect(find('ul.list-group')).to have_selector('li', count: 2)
    end

    scenario 'Find inactive groups' do
      visit_group_main_page
      click_link 'Inactive groups'
      expect(find('ul.list-group')).to have_selector('li', count: 1)
    end

    def visit_group_main_page
      visit root_path
      click_link 'Groups'
    end
  end
end
