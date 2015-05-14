require 'spec_helper'

describe Post do

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