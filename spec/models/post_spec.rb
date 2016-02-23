# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  description  :text
#  picture      :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  person_id    :integer
#  draft        :boolean          default(FALSE), not null
#  slug         :string(255)
#  published_at :datetime
#

require 'spec_helper'

describe Post do

  # this is an example for how to test scopes using the database. See convo here: https://github.com/rubycorns/rorganize.it/pull/341
  describe '.published_descending_order' do
    subject { described_class.published_descending_order }

    it 'includes only published posts' do
      published = create(:post, draft: false)
      create(:post, draft: true, slug: 'post-1')

      expect(subject).to contain_exactly(published)
    end

    it 'sorts by published_at, latest first' do
      create(:post, draft: false, published_at: '2015-04-01', slug: 'post-2')
      create(:post, draft: false, published_at: '2015-03-01', slug: 'post-3')
      create(:post, draft: false, published_at: '2015-05-01', slug: 'post-4')

      expect(subject.map(&:published_at))
        .to eq([
          Date.parse('2015-05-01'),
          Date.parse('2015-04-01'),
          Date.parse('2015-03-01'),
        ])
    end
  end

  describe '.draft' do
    subject { described_class.draft }

    it 'includes only draft posts' do
      create(:post, draft: false)
      draft = create(:post, draft: true, slug: 'post-5')

      expect(subject).to contain_exactly(draft)
    end
  end

  describe '.published_descending_order' do
    subject { described_class.published_descending_order }

    it 'includes published posts from newest to oldest' do
      post2 = create(:post, draft: true, slug: 'post-2')
      post3 = create(:post, draft: false, published_at: '2015-03-01', slug: 'post-catsarecool')
      post4 = create(:post, draft: false, published_at: '2015-05-01', slug: 'post-dogsaredope')

      expect(subject.first).to eql(post4)
      expect(subject).to contain_exactly(post3, post4)
    end
  end


  it { is_expected.to belong_to(:person) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }

  describe '#set_published_at!' do
    let(:post) { create :post, published_at: nil }
    test_date = Date.new(2015, 05, 12)

    before do
      Timecop.freeze(test_date)
      post.set_published_at!
    end

    after { Timecop.return }

    it 'sets the correct date' do
      expect(post.published_at).to eq test_date
    end
  end
end
