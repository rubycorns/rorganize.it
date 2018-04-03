# coding: utf-8
require 'spec_helper'

feature 'filter groups', vcr: {cassette_name: 'create_group'} do
  context 'by location' do
    let!(:group) { create(:group, name: 'Zürich CH', city: 'Zürich', country: 'CH')}
    let!(:group) { create(:group, name: 'Paris FR', city: 'Paris', country: 'FR')}
    let!(:group) { create(:group, name: 'Basel CH', city: 'Basel', country: 'CH')}
    let!(:group) { create(:group, name: 'Basel FR', city: 'Basel', country: 'FR')}

    scenario 'by city' do
      visit_group_main_page
      expect(find('ul.list-group')).to have_selector('li', count: 4)
      select 'Zürich', from: 'City'
      click_button 'Filter'
      expect(find('ul.list-group')).to have_selector('li', count: 1)
      show_groups(["Zürich CH"])
    end

    scenario 'by country' do
      visit_group_main_page
      expect(find('ul.list-group')).to have_selector('li', count: 4)
      select 'France', from: 'Country'
      click_button 'Filter'
      expect(find('ul.list-group')).to have_selector('li', count: 2)
      show_groups(["Paris FR", "Basel FR"])
    end

    scenario 'by city and country' do
      visit_group_main_page
      expect(find('ul.list-group')).to have_selector('li', count: 4)
      select 'Basel', from: 'City'
      select 'France', from: 'Country'
      click_button 'Filter'
      expect(find('ul.list-group')).to have_selector('li', count: 1)
      show_groups(["Basel FR"])
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
