require 'spec_helper'

feature 'admins can delete groups', :vcr => {:cassette_name => "create_group" } do

  before { visit new_person_session_path }

  let(:person) { create(:person) }
  let!(:group) { create(:group) }

  context 'visitor' do

    it 'does not show the delete link' do
      user_visits_group_page
      delete_link_is_not_visible
    end
  end

  context 'signed in person' do
    before do
      sign_in person
    end

    scenario 'admin deletes a group' do
      person.update_attribute(:admin, true)
      user_visits_group_page
      user_deletes_group
      group_has_been_deleted
    end

    scenario 'non-admin can not delete a group' do
      user_visits_group_page
      delete_link_is_not_visible
    end
  end

  def user_visits_group_page
    visit groups_path
  end

  def user_deletes_group
    click_link 'delete'
  end

  def group_has_been_deleted
    expect(Group.exists?(group.id)).to be_falsey
  end

  def delete_link_is_not_visible
    expect(page).not_to have_content('delete')
  end

end
