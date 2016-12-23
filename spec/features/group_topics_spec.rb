require 'spec_helper'

feature 'Manage topics of a group', :vcr => {:cassette_name => "create_group" } do

  scenario 'Add topic' do
    sign_in_user
    visit_group_topics_page
    add_topic
    topic_is_in_list_of_future_topics
  end

  scenario 'Mark topic as covered' do
    sign_in_user
    group_has_future_topics
    visit_group_topics_page
    mark_one_topic_as_covered
    topic_is_in_list_of_covered_topics
  end

  scenario 'View topic as not signed user' do
    visit_group_topics_page
    cannot_see_topic_form
  end

  let(:person) { create(:person) }
  let(:group) { create(:group) }

  def sign_in_user
    visit new_person_session_path
    sign_in person
    person.join!(group, 'StudentMembership')
  end

  def group_has_future_topics
    group.topics.create!(person: person, body: 'Talk about databases')
    group.topics.create!(person: person, body: 'Talk about animated gifs')
  end

  def mark_one_topic_as_covered
    within('.future-topics .topics > li:first-of-type') do
      click_link 'Done'
    end
  end

  def visit_group_topics_page
    visit group_topics_path(group.id)
  end

  def add_topic
    fill_in 'Suggest a topic', with: 'Talk about databases'
    click_button 'Create Topic'
  end

  def topic_is_in_list_of_future_topics
    within('.future-topics') do
      expect(page).to have_content('Talk about databases')
    end
  end

  def topic_is_in_list_of_covered_topics
    within('.covered-topics') do
      expect(page).to     have_content('Talk about databases')
      expect(page).to_not have_content('Talk about animated gifs')
    end
    within('.future-topics') do
      expect(page).to_not have_content('Talk about databases')
      expect(page).to     have_content('Talk about animated gifs')
    end
  end

  def cannot_see_topic_form
    expect(page).to have_content("Topics by #{group.name}")
    expect(page).to_not have_content('Suggest a topic')
  end
end
