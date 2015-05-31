require 'spec_helper'

describe Post do

  describe 'scopes' do
    specify do
      expect(Post.published.to_sql).to eql "SELECT \"posts\".* FROM \"posts\"  WHERE \"posts\".\"draft\" = 'f'  ORDER BY \"posts\".\"published_on\" DESC"
      expect(Post.draft.to_sql).to eql "SELECT \"posts\".* FROM \"posts\"  WHERE \"posts\".\"draft\" = 't'  ORDER BY \"posts\".\"created_at\" DESC"
    end
  end

  describe '.published' do
    subject { described_class.published }

    it 'includes only published posts' do
      published = create(:post, draft: false)
      create(:post, draft: true)

      expect(subject).to contain_exactly(published)
    end

    it 'sorts by published_on, latest first' do
      create(:post, draft: false, published_on: '2015-04-01')
      create(:post, draft: false, published_on: '2015-03-01')
      create(:post, draft: false, published_on: '2015-05-01')

      expect(subject.map(&:published_on))
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
      draft = create(:post, draft: true)

      expect(subject).to contain_exactly(draft)
    end
  end

  it { is_expected.to belong_to(:person) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }

  describe '#set_published_on!' do
    let(:post) { create :post, published_on: nil }
    test_date = Date.new(2015, 05, 12)

    before do
      Timecop.freeze(test_date)
      post.set_published_on!
    end

    after { Timecop.return }
    
    it 'sets the correct date' do
      expect(post.published_on).to eql test_date
    end
  end
end
