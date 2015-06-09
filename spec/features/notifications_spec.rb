require 'spec_helper'

feature 'Notifications' do

  subject { page }

  let(:person) { create(:person) }

  before do
    visit new_person_session_path
    sign_in person
    person.update_attribute(:admin, true)
  end

  scenario 'send, read and delete' do
    go_to_notifications_page
    fill_in_notification
    notification_is_visible
    mark_notification_as_read
    mark_notification_as_not_read
    delete_notification
  end

  def go_to_notifications_page
    visit 'notifications/new'
    expect(page).to have_content('New notification')
  end

  def fill_in_notification
    select 'Ruby Corn'
    fill_in 'Content', with: 'A new notification'
    click_button 'Broadcast'
  end

  def notification_is_visible
    expect(page).to have_selector('.notifications .badge')
    within '.notifications .badge' do
      expect(page).to have_content('1')
    end
  end

  def mark_notification_as_read
    expect(page).to have_selector '.notifications-list li.unread'
    click_button 'read'
    expect(page).to have_selector '.notifications-list li.read'
  end

  def mark_notification_as_not_read
    expect(page).to have_selector '.notifications-list li.read'
    click_button 'read'
    expect(page).to have_selector '.notifications-list li.unread'
  end

  def delete_notification
    expect(page).to have_selector('.notifications-list li')
    click_button 'delete'
    expect(page).to_not have_selector('.notifications-list li')
    expect(page).to_not have_selector('.notifications .badge')
  end

end
