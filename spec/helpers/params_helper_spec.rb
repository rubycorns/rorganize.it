require 'spec_helper'

RSpec.describe ParamsHelper, type: :helper do
  describe 'testing params' do

    context 'trim_params' do
      input_params = { country: 'DE', name: ' franka ', email: ' hi@email.com', website: 'https://mywebsite.com '}
      expected_params = { country: 'DE', name: 'franka', email: 'hi@email.com', website: 'https://mywebsite.com'}
#      params = helper.trim_params(input_params)
      expect(helper.trim_params(input_params)).to equal(expected_params)
    end
  end
end
