require 'spec_helper'

describe 'Simple Tests that have nothing to do with the app' do

  it 'can do basic math' do
    expect(4 + 2).to eq 6
  end

  it 'can have negative expectations' do
    expect(1 + 7).not_to eq 9
  end

  describe 'setup' do
    before :each do
      @sum = 1 + 2 + 3 + 4
    end

    it 'has the sum of 10' do
      expect(@sum).to eq 10
    end

    it 'can be multiplied' do
      expect(@sum * 10).to be <= 200
    end
  end

  describe 'memoization' do
    let(:sum) { 1 + 2 + 3 + 4}

    it 'hast the sum of 10' do
      expect(sum).to eq 10
    end

    it 'does not execute sum when not called' do
      expect(nil).to be_nil
    end
  end

  describe 'matchers' do
    it 'can compare things' do
      expect(100).to be >= 90
    end
  end

end