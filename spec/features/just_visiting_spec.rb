require 'spec_helper'

describe 'Visiting' do
  subject { page }

  let(:person) { create(:person) }

  context 'the home page' do

    before do
      visit root_path
    end

    it 'should have the greeting' do
      page.should have_content 'Find other Rails Girls students, coaches and project groups!'
    end
  end

  context 'the groups#index' do

    before do
      visit '/groups'
    end

    it 'should have a list of groups' do
      page.should have_content 'Groups overview'
    end
  end

  context 'the groups#show' do

    let!(:group) { create(:group) }

    before do
      visit '/groups/1'
    end

    it 'should show some group info' do
      page.should have_content 'Coding since'
    end
  end

  context 'the people#index' do

    before do
      visit '/people'
    end

    it 'should show a list of people' do
      page.should have_content 'People overview'
    end
  end

  context 'the people#show' do

    let(:person) { create(:person) }

    before do
      visit '/people/1'
    end

    it 'should redirect to sign in' do
      page.should have_content 'You need to sign in'
    end
  end

  context 'the blog' do

    before do
      visit '/posts'
    end

    it 'should show some posts' do
      page.should have_content 'Corporate Blog'
    end
  end


end