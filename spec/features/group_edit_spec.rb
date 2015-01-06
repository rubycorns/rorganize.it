require 'spec_helper'

feature 'edit a group' do

  before { visit new_person_session_path }
  before { sign_in person }

  let(:person) { create(:person) }
  let(:group) { create(:group) }

  before { person.join!(group, 'StudentMembership') }

  scenario 'edit the name of an existing group' do
    visit root_path
    click_link 'Groups'
    expect(page).to have_content('edit')
    click_link 'edit'
    expect(page).to have_content('Edit group')
    expect(page).to_not have_content('Join group as coach')
    fill_in 'Project group name', with: 'Testgroup'
    click_button 'Update Group'

    within('.page-header') do
      expect(page).to have_content('Testgroup')
    end
  end

  scenario 'upload an image' do
    visit root_path
    click_link 'Groups'
    expect(page).to have_content('edit')
    click_link 'edit'
    attach_file('group_picture', Rails.root.join('spec/fixtures/image_to_upload.jpg'))
    click_button 'Update Group'
    
    #expect(page.body).to eq(Rails.root.join('spec/fixtures/marker_expected.png').read)
    
  end

end