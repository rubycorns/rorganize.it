require 'spec_helper'

feature 'Blog drafts' do
  subject { page }
  before { login_as_admin }

  scenario 'post a draft' do
    go_to_blog
    create_new_post
    save_as_draft
    is_visible_to_admins
    is_not_visible_to_users
  end

  def login_as_admin
    person = create(:person)
    person.add_role(:admin)
    visit new_person_session_path
    sign_in person
  end

  def go_to_blog
    click_link 'Blog'
  end

  def create_new_post
    click_link 'New Post'
    puts current_path
  end

  def save_as_draft
    fill_in 'Blogpost title', with: 'Hello World'
    fill_in 'Text', with: 'Hello again'
    click_button 'Save as Draft'
  end

  def is_visible_to_admins
    click_link 'Blog'
    expect(page).to have_content('Hello World')
  end

  def is_not_visible_to_users
    click_link 'logout'
    click_link 'Blog'
    expect(page).to_not have_content('Hello World')
  end
end
