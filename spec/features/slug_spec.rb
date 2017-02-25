require 'spec_helper'

feature 'slugs', vcr: {cassette_name: 'create_group'} do

  before { visit new_person_session_path }

  let(:person) { create(:person) }
  let!(:group) { create(:group, name: 'Rubycorns', slug: 'rubycorns') }
  let!(:post) { create(:post, title: 'Some Awesome Blog Post', slug: 'some-awesome-blog-post') }

  scenario 'take user to right group page' do
  	visit_group_slug
    group_page_is_rendered
    visit_group_id_path
    group_page_is_rendered
  end

  scenario 'blog slugs' do
    visit_blog_post_slug
    post_page_is_rendered
    visit_blog_post_id_path
    post_page_is_rendered
  end

  def visit_group_slug
    visit '/groups/rubycorns'
  end

  def visit_group_id_path
    visit "/groups/#{group.id}"
  end

  def group_page_is_rendered
    expect(page).to have_content('Rubycorns')
  end

  def visit_blog_post_slug
    visit '/posts/some-awesome-blog-post'
  end

  def visit_blog_post_id_path
    visit "/posts/#{post.id}"
  end

  def post_page_is_rendered
    expect(page).to have_content('Some Awesome Blog Post')
  end

end
