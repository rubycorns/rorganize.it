task set_admin_role: :environment do
  puts "finding admins"
  people = Person.with_role(:admin)

  puts 'setting the admin boolean'
  people.map do |person|
    person.update_attribute(:admin, true)
  end

  puts 'done! have some cake'
end