require 'spec_helper'

feature 'People List' do
	
	let(:person) { create(:person) }
	let!(:person2) { create(:second_person) }


	scenario 'Current user highlighted when signed in' do
		visit new_person_session_path
		sign_in person
		visit people_path
		expect(page).to have_selector('.list-group-item-warning', text: person.name)
		expect(page).to_not have_selector('.list-group-item-warning', text: person2.name)
	end
end
