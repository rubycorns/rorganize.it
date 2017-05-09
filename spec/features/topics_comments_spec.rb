require 'spec_helper'

feature 'Comments on topics', vcr: {cassette_name: 'create_group'} do

  scenario 'Add a comment to a topic' do
    visit_group_topic_page
    add_comment
    comment_is_visible_on_topic
  end

  scenario 'Failing to add empty topic' do
    visit_group_topic_page
    try_adding_empty_comment
    comment_not_visible_on_topic
  end

  let(:person) { create(:person) }
  let(:group) { create(:group) }
  let(:topic) { create(:topic, group: group, body: "Let's talk about making and eating cake")}

  before do
    visit new_person_session_path
    sign_in person
    person.join!(group, {})
  end

  def visit_group_topic_page
    visit group_topic_path(group.slug, topic.id)

    within('.topic-main p:first-of-type') do
      expect(page).to have_content("Let's talk about making and eating cake")
    end
  end

  def add_comment
    within('.topic-comment-form') do
      fill_in 'Leave a comment', with: 'I love cake!'
      click_button 'Create Comment'
    end
  end

  def comment_is_visible_on_topic
    within('.topic-comments') do
      expect(page).to have_content('I love cake!');
    end
  end

  def try_adding_empty_comment
    within('.topic-comment-form') do
      click_button 'Create Comment'
    end
  end

  def comment_not_visible_on_topic
    within('.topic-comments') do
      expect(page).to_not have_content('I love cake!');
    end
  end

end
