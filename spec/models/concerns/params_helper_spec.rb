require 'spec_helper'

RSpec.describe ParamsHelper, vcr: {cassette_name: "param_helper" } do
  describe 'testing params' do
    let(:a_person)    { create :person, country: 'DE', name: ' franka ', email: ' hi@email.com', website: 'https://mywebsite.com '}
    let(:a_group)    { create :person, country: 'DE', name: ' franka ', email: ' hi@email.com', website: 'https://mywebsite.com '}

    let(:new_person)    { update :a_person, country: 'DE', name: ' franka ', email: ' hi@email.com', website: 'https://mywebsite.com '}
    let(:new_group)    { update :a_group, country: 'DE', name: ' franka ', email: ' hi@email.com', website: 'https://mywebsite.com '}


    context 'on person#create' do
      it 'trims spaces' do
        expect(a_person.name).to eq 'franka'
        expect(a_person.email).to eq 'hi@email.com'
        expect(a_person.website).to eq 'https://mywebsite.com'
      end
    end

    context 'on person#update' do
      it 'trims spaces' do
        expect(new_person.name).to eq 'franka'
        expect(new_person.email).to eq 'hi@email.com'
        expect(new_person.website).to eq 'https://mywebsite.com'
      end
    end

    context 'on group#create' do
      it 'trims spaces' do
        expect(a_group.name).to eq 'franka'
        expect(a_group.email).to eq 'hi@email.com'
        expect(a_group.website).to eq 'https://mywebsite.com'
      end
    end

    context 'on group#update' do
      it 'trims spaces' do
        expect(new_group.name).to eq 'franka'
        expect(new_group.email).to eq 'hi@email.com'
        expect(new_group.website).to eq 'https://mywebsite.com'
      end
    end

  end
end
