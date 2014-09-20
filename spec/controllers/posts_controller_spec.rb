require 'spec_helper'

describe PostsController do
  describe 'index' do

    context 'no posts whatsoever' do

      before :each do
        get :index
      end

      it 'is successful' do
        expect(response).to be_success
      end

      it 'has an empty posts' do
        expect(assigns(:posts)).to be_empty
      end
    end

    context 'with a couple of posts' do

      before :each do
        5.times {Post.create title: 'random', description: 'important stuff' }
        get :index
      end

      it 'has 5 of them as posts' do
        posts = assigns(:posts)
        post_size = posts.count
        expect(post_size).to eq 5
      end

    end
  end
end
