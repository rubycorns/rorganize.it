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

  scenario 'Request membership of existing group' do
    sign_in_user
    request_group_membership
    check_not_group_admin
    can_not_edit_group
    has_pending_membership
  end

  scenario 'Be group admin and accept membership request' do
    be_group_admin_of_group_with_pending_membership
    accept_membership
    group_has_new_member
    group_has_no_pending_memberships
  end

  scenario 'Be group admin and reject membership request' do
    be_group_admin_of_group_with_pending_membership
    reject_membership
    group_has_no_new_member
    group_has_no_pending_memberships
  end

  scenario 'Be group admin and make another member admin' do
    be_group_admin
    make_another_member_admin
  end

  let(:person) { create(:person) }
  let(:group) { create(:group) }
  let(:person2) { create(:second_person) }

  def be_group_admin_of_group_with_pending_membership
    be_group_admin
    click_on 'logout'
    group_has_pending_memberships
    sign_in_user
  end

  def accept_membership
    go_to_manage_members
    within '.group_invites' do
      click_on 'accept'
    end
    expect(page).to have_content('New member accepted, hopefully there will be cake!')
  end

  def reject_membership
    go_to_manage_members
    within '.group_invites' do
      click_on 'reject'
    end
    expect(page).to have_content('Rejection successful, hopefully they\'ll have cake.')
  end

  def group_has_new_member
    go_to_admin_group
    expect(page).to have_content(person2.first_name)
  end

  def group_has_no_new_member
    go_to_admin_group
    expect(page).to_not have_content(person2.first_name)
  end

  def group_has_pending_memberships
    visit new_person_session_path
    sign_in person2
    go_to_admin_group
    click_on 'Request Membership!'
    click_on 'logout'
  end

  def group_has_no_pending_memberships
    go_to_admin_group
    click_on 'Manage members'
    expect(page).to have_content('No requests')
  end

  def go_to_admin_group
    visit groups_path
    click_on 'My new group'
  end

  def go_to_manage_members
    go_to_admin_group
    expect(page).to have_content('Manage members 1')
    click_on 'Manage members 1'
  end

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

  def request_group_membership
    visit group_path(group)
    click_on 'Request Membership!'
  end

  def check_not_group_admin
    expect(page).to_not have_content('Manage members')
  end

  def can_not_edit_group
    expect(page).to_not have_content('Edit group')
  end

  def has_pending_membership
    visit group_path(group)
    expect(page).to have_content('You requested membership for this group on')
    within '.profile-header' do
      find('.person-profile a:last-of-type').click
    end
    expect(page).to have_content("You're waiting for membership confirmation from these groups")
    within '#group_invites' do
      expect(page).to have_selector('.list-group-item')
    end
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
