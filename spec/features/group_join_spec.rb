require 'spec_helper'

feature 'User joins a group', :vcr => {:cassette_name => "create_group" } do
  scenario 'join a group' do
    visit_group_page
    click_join_button
    edit_default_message
  end

  # let(:person) { create(:person) }
  # let(:group) { create(:group) }

  def visit_group_page
    create(:group, name: 'rubycorns')
    person = create(:person)
    visit new_person_session_path
    sign_in person
    click_link 'Groups'
    click_link 'rubycorns'
  end

  def click_join_button
    click_button 'Join this group'
  end

  def edit_default_message
    fill_in('contact_message', with: 'let me join the coolest group')
  end
end
