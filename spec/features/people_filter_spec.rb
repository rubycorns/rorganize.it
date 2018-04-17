# coding: utf-8
require 'spec_helper'

feature 'filter people', vcr: {cassette_name: 'create_person'} do
  context 'by location' do
    let!(:person_1) { create(:person, name: 'Zürich CH', city: 'Zürich', country: 'CH')}
    let!(:person_2) { create(:person, name: 'Paris FR', city: 'Paris', country: 'FR')}
    let!(:person_3) { create(:person, name: 'Basel CH', city: 'Basel', country: 'CH')}
    let!(:person_4) { create(:person, name: 'Basel FR', city: 'Basel', country: 'FR')}

    scenario 'by city' do
      visit_people_main_page
      expect(find('ul.list-group')).to have_selector('li.list-group-item', count: 4)
      select 'Zürich', from: 'City'
      click_button 'Filter'
      expect(find('ul.list-group')).to have_selector('li.list-group-item', count: 1)
      show_people(["Zürich CH"])
    end

    scenario 'by country' do
      visit_people_main_page
      expect(find('ul.list-group')).to have_selector('li.list-group-item', count: 4)
      select 'France', from: 'Country'
      click_button 'Filter'
      expect(find('ul.list-group')).to have_selector('li.list-group-item', count: 2)
      show_people(["Paris FR", "Basel FR"])
    end

    scenario 'by city and country' do
      visit_people_main_page
      expect(find('ul.list-group')).to have_selector('li.list-group-item', count: 4)
      select 'Basel', from: 'City'
      select 'France', from: 'Country'
      click_button 'Filter'
      expect(find('ul.list-group')).to have_selector('li.list-group-item', count: 1)
      show_people(["Basel FR"])
    end

    def visit_people_main_page
      visit root_path
      click_link 'People'
    end

    def show_people(people_list)
      people_list.map do |name|
        expect(page).to have_content(name)
      end
    end
  end
end
