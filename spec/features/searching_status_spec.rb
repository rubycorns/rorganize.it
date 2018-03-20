
require 'spec_helper'

feature 'Searching', vcr: {cassette_name: 'create_group'} do
  before do
    visit new_person_session_path
    sign_in person
  end

  context 'for a group as a person' do
    let(:person) { create(:person) }

    it 'adding searching status' do
      does_not_display_searching_for_group
      go_to_person_settings
      check_searching_for_group_and_save
      displays_searching_for_groups_tag
    end
  end

  context 'for people and location as a group' do
    let(:person) { create(:person) }
    let(:group) { create(:group) }

    before { person.join!(group, admin: true) }

    it 'add searching flags via settings' do
      does_not_display_searching_for_coaches
      go_to_group_settings
      check_searching_for_coaches_and_save
      displays_searching_for_coaches_status

      does_not_display_searching_for_students
      go_to_group_settings
      check_searching_for_students_and_save
      displays_searching_for_students_status

      does_not_display_searching_for_location
      go_to_group_settings
      check_searching_for_location_and_save
      displays_searching_for_location_status
    end
  end


  def does_not_display_searching_for_group
    visit person_path(person)
    expect(page).to_not have_content('searching group')
  end

  def go_to_person_settings
    click_link 'Edit profile'
  end

  def check_searching_for_group_and_save
    check 'I\'m searching for a group'
    click_button 'Save'
  end

  def displays_searching_for_groups_tag
    visit person_path(person)
    expect(page).to have_content('Searching for a group!')
  end

  def does_not_display_searching_for_coaches
    visit group_path(group)
    expect(page).to_not have_content('searching for coaches')
  end

  def go_to_group_settings
    click_on 'Edit group'
  end

  def check_searching_for_coaches_and_save
    check 'This group is searching for coaches'
    click_button 'Update Group'
  end

  def displays_searching_for_coaches_status
    visit group_path(group)
    expect(page).to have_content('searching for coaches')
  end

  def does_not_display_searching_for_students
    visit group_path(group)
    expect(page).to_not have_content('searching for students')
  end

  def check_searching_for_students_and_save
    check 'This group is searching for students'
    click_button 'Update Group'
  end

  def displays_searching_for_students_status
    visit group_path(group)
    expect(page).to have_content('searching for students')
  end

  def does_not_display_searching_for_location
    visit group_path(group)
    expect(page).to_not have_content('searching for a place to meet')
  end

  def check_searching_for_location_and_save
    check 'This group needs a meeting place'
    click_button 'Update Group'
  end

  def displays_searching_for_location_status
    visit group_path(group)
    expect(page).to have_content('searching for place to meet')
  end
end
