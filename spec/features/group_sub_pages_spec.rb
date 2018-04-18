require 'spec_helper'

feature 'Explore group sub pages', vcr: {cassette_name: 'create_group'} do
  context 'as not logged in user' do
    let!(:group) { create(:group, full: true, created_at: 8.months.ago, name: "A full and old group") }
    let!(:group2) { create(:group, inactive: true, name: "An inactive group") }
    let!(:group3) { create(:group, searching_students: true, name: "A group searching") }

    scenario 'Find all groups on index page' do
      visit_group_main_page
      expect(find('ul.list-group')).to have_selector('li', count: 2)
      show_groups(["A group searching", "A full and old group"])
    end

    scenario 'Find groups searching for something' do
      visit_group_main_page
      click_link 'Groups searching'
      expect(find('ul.list-group')).to have_selector('li', count: 1)
      show_groups(["A group searching"])
    end

    scenario 'Find groups added in the last 6 months' do
      visit_group_main_page
      click_link 'Recently added'
      expect(find('ul.list-group')).to have_selector('li', count: 2)
      show_groups(["A group searching", "An inactive group"])
    end

    scenario 'Find inactive groups' do
      visit_group_main_page
      click_link 'Inactive groups'
      expect(find('ul.list-group')).to have_selector('li', count: 1)
      show_groups(["An inactive group"])
    end

    def visit_group_main_page
      visit root_path
      click_link 'Groups'
    end

    def show_groups(group_list)
      group_list.map do |name|
        expect(page).to have_content(name)
      end
    end
  end
end
