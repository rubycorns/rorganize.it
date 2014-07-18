require 'spec_helper'

describe PostsController do
  describe 'index' do

    context 'no posts whatsoever' do

      before :each do
        get :index
      end

      it 'should be successful' do
        expect(response).to be_success
      end

      it 'has an empty posts' do
        expect(assigns(:posts)).to be_empty
      end
    end

    context 'with a couple of posts' do

      before :each do
        5.times {Post.create title: 'random', description: 'important stuff' }
        Post.create title: 'latest',
                    description: 'hhrm',
                    created_at: 2.days.from_now
        get :index
      end

      it 'has 5 of them as posts' do
        expect(assigns(:posts).size).to eq 5
      end

      it 'has a first_post' do
        expect(assigns(:latest_post).title).to eq 'latest'
      end
    end
  end
end