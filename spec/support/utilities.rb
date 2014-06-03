def sign_in(person)
  fill_in 'Email', with: person.email
  fill_in 'Password', with: person.password
  #click_button 'Sign in'
  find("#test").click
end