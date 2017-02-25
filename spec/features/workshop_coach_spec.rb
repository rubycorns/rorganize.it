require 'spec_helper'

feature 'workshop coach' do
  before { login_as_user }

  scenario 'see workshop coach text' do
    visit_profile_page_of_a_workshop_coach
    see_workshop_coach_text
    visit_profile_of_normal_person
    not_see_workshop_coach_text
  end

  def login_as_user
    person = create(:person)
    visit new_person_session_path
    sign_in person
  end

  def coach_text
    'I am willing to coach at Rails Girls workshops'
  end

  def see_workshop_coach_text
    expect(page).to have_content(coach_text)
  end

  def not_see_workshop_coach_text
    expect(page).not_to have_content(coach_text)
  end

  def visit_profile_page_of_a_workshop_coach
    person = create(:person, first_name: 'Sara', workshop_coach: true)
    click_link 'All people'
    click_link 'Sara'
  end

  def visit_profile_of_normal_person
    person = create(:person, first_name: 'Foobar', workshop_coach: false)
    click_link 'All people'
    click_link 'Foobar'
  end

end
