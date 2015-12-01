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
        expect(assigns(:published_posts)).to be_empty
      end
    end

    context 'with a couple of posts' do
      before :each do
        2.times { Post.create title: 'random', description: 'important stuff', draft: false }
        get :index

        1.times { Post.create title: 'draft', description: 'draft', draft: true }
      end

      it 'has 2 published posts' do
        expect(assigns(:published_posts).to_a.size).to eq 2
      end
    end

    context 'with pagination' do
      before :each do
        7.times { Post.create title: 'random', description: 'important stuff', draft: false }
        get :index
      end

      it 'has 5 published posts' do
        expect(assigns(:published_posts).to_a.size).to eq 5
      end
    end

  end

  describe 'create' do
    test_date = Date.new(2015, 05, 12)

    before do
      Timecop.freeze(test_date)
      allow(controller).to receive :authenticate_person!
      allow(controller).to receive(:current_person).and_return(person)
    end

    after { Timecop.return }

    let(:person) { create :person }
    let(:params) {{ post: {title: 'something', description: 'stuff'}, commit: 'Publish'} }

    context 'creating a post' do
      context 'as a non-admin' do

        it 'does not create a post' do
          expect do
            post :create, params
          end.to_not change{ Post.count}
        end
      end

      context 'as an admin' do

        before do
          person.admin = true
        end

        context 'publishing the post' do
          it 'is successful' do
            expect do
              post :create, params
            end.to change{ Post.count}.by(1)
          end

          it 'does not mark the post as a draft' do
            post :create, params
            expect(Post.last.draft).to be false
          end

          it 'sets the correct published_on date' do
            post :create, params
            expect(Post.last.published_on).to eq test_date
          end

          it 'redirects to the post' do
            post :create, params
            expect(response).to redirect_to post_path(Post.last)
          end
        end

        context 'saving the post as draft' do
          let(:params)  {
                          { post:
                            { title: 'something',
                              description: 'stuff'
                            },
                          commit: 'Save as draft'
                          }
                        }

          it 'is successful' do
            expect do
              post :create, params
            end.to change{ Post.count}.by(1)
          end

          it 'marks the post as a draft' do
            post :create, params
            expect(Post.last.draft).to be true
          end

          it 'sets the correct published_on date' do
            post :create, params
            expect(Post.last.published_on).to be_nil
          end

          it 'redirects to the post' do
            post :create, params
            expect(response).to redirect_to post_path(Post.last)
          end
        end
      end
    end
  end

  describe 'update' do
    before do
      allow(controller).to receive :authenticate_person!
      allow(controller).to receive(:current_person).and_return(person)
    end

    let(:person) { create :admin }
    let(:post)   { create :post, published_on: Date.new(2015, 01, 01) }
    let(:params)  {
                    { post:
                      { title: 'blargh!',
                        description: 'things are happening!'
                      },
                      id: post.id,
                      commit: 'Publish'
                    }
                  }

    context 'as an admin' do

      before do
        allow(Post).to receive(:find).and_return(post)
      end

      context 'updating the post' do
        it 'is successful' do
          expect do
            put :update, params
          end.to_not change{ Post.count }
        end

        it 'does not mark the post as a draft' do
          put :update, params
          expect(post.draft).to be false
        end

        it 'keeps the old published_on date' do
          put :update, params
          expect(post.published_on).to eq Date.new(2015, 01, 01)
        end

        it 'redirects to the post' do
          put :update, params
          expect(response).to redirect_to post_path(post)
        end
      end

      context 'publishing a draft' do
        test_date = Date.new(2015, 05, 12)
        before { Timecop.freeze(test_date) }
        after { Timecop.return }

        let(:post) { create :post, draft: true, published_on: nil }

        it 'sets draft to false, b/c it is published' do
          put :update, params
          expect(Post.find_by(slug: 'a-blogpost').draft).to be false
        end

        it 'sets the correct published_on date' do
          put :update, params
          expect(Post.find_by(slug: 'a-blogpost').published_on).to eq test_date
        end

        it 'redirects to the post' do
          put :update, params
          expect(response).to redirect_to post_path(post)
        end
      end
    end
  end
end
