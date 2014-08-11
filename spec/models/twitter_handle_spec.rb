require 'spec_helper'

class TwitterHandleTester < Hash

	include TwitterHandle

	def twitter
		 self[:twitter]
	end

end

describe TwitterHandle do

  subject {TwitterHandleTester.new}

  describe 'no twitter' do

	  it 'does not have twitter' do
	  	expect(subject.has_twitter?).to be_falsey
		end

		it 'has empty handle' do
	  	expect(subject.twitter_handle).to eq ''
		end

		it 'has empty twitter url' do
	  	expect(subject.twitter_profile_url).to eq ''
	  end

	end

	describe 'has twitter' do

		before :each do
			subject.twitter = 'github'
		end

	  it 'has twitter handle' do
	  	expect(subject.has_twitter?).to be_truthy
  	end

  	it 'returns handle' do
	  	expect(subject.twitter_handle).to eq '@github'
		end

		it 'returns twitter url' do
	  	expect(subject.twitter_profile_url).to eq 'https://twitter.com/github'
	  end

  end

  it 'removes the @ is added' do
	  	subject.twitter = '@knut'
	  	expect(subject.twitter).to eq 'knut'
	end

end
