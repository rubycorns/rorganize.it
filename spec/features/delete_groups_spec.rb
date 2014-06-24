require 'spec_helper'

feature 'admins can delete groups' do

  before { visit new_person_session_path }

  let(:person) { create(:person) }
  let!(:group) { create(:group) }

  before do
    person.add_role :admin
    sign_in person
  end

  scenario 'admin deletes a group' do

    admin_goes_to_groups_page

    admin_deletes_group

    group_has_been_deleted

  end

  def admin_goes_to_groups_page
    visit groups_path
  end

  def admin_deletes_group
    click_link 'delete'
  end

  def group_has_been_deleted
    Group.exists?(group.id).should be_false
  end

end