require 'spec_helper'

feature 'Manage group members', vcr: { cassette_name: 'create_group' } do
  matcher :allow_edit_group do
    match { |actual| have_content('Edit group').matches?(actual) }
  end

  matcher :allow_manage_members do
    match { |actual| have_content('Manage members').matches?(actual) }
  end

  scenario 'Create a group and be admin of it' do
    sign_in_user
    create_group
    check_group_admin
    can_edit_group
  end

  scenario 'Join existing group and not be admin of it' do
    sign_in_user
    join_group
    check_not_group_admin
    can_not_edit_group
  end

  scenario 'Be group admin and make another member admin' do
    be_group_admin
    make_another_member_admin
  end

  let(:person) { create(:person) }
  let(:group) { create(:group) }

  def sign_in_user
    visit new_person_session_path
    sign_in person
  end

  def create_group
    visit groups_path
    click_link 'Register new group'
    fill_in 'Group name', with: 'My new group'
    fill_in 'Where we\'ll send automated emails to', with: 'mail@mail.de'
    fill_in 'City', with: 'Berlin'
    select 'Australia', from: 'Country'
    fill_in 'Group contact info', with: 'Hallo'
    click_button 'Create Group'
  end

  def check_group_admin
    within '.sub-nav' do
      expect(page).to have_content('Manage members')
    end
  end

  def can_edit_group
    within '.sub-nav' do
      expect(page).to have_content('Edit group')
    end
  end

  def join_group
    visit group_path(group)
    click_on 'Join as a student!'
  end

  def check_not_group_admin
    expect(page).to_not have_content('Manage members')
  end

  def can_not_edit_group
    expect(page).to_not have_content('Edit group')
  end

  def be_group_admin
    sign_in_user
    create_group
  end

  def make_another_member_admin
    click_on 'Manage members'
    expect(page).to have_content(person.name)
    click_on 'remove admin status'
    expect(page).to_not have_content('Manage members')
  end
end
