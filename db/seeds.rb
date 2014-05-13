# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

group_list = [
  {
    name: 'The Thursday Group',
    address: 'modomoto office, Blücherstraße 22, 10961 Berlin',
    time: 'Thursday 19:00',
    contact: 'https://groups.google.com/forum/#!forum/rails-girls-berlin-project-group-thursdays',
    activities: 'We build a wishlist app to organize christmas for large families. Users can enter their own wishlist and add wishes. Other users can comment on these wishes, mark them as done etc, but the list owner can’t see that of course.',
    email: 'group1@example.org'
  },
  {
    name: 'The Rubycorns',
    address: 'Travis Office, Prinzessinnenstr. 20, 10969 Berlin',
    time: 'Tuesday 19:00',
    contact: 'https://groups.google.com/forum/#!forum/rails-girls-berlin-project-group-tuesdays',
    activities: 'We basically meet and have coding sessions where we show of stuff as needed. Sometimes Tobi gives a presentation from his HU course or something. Basically everything including homeworks is pretty ad-hoc.',
    email: 'group2@example.org'
  },
  {
    name: 'The Co.Up Group',
    address: 'co.up Coworking Adalbertstraße 8, 10999 Berlin',
    time: 'Tuesday 19:00',
    contact: '',
    activities: 'Nothing specific, we do exercises around basic web apps with Sinatra.',
    email: 'group3@example.org'
  },
  {
    name: 'The Ruby Monsters',
    address: 'Travis Office, Prinzessinnenstr. 20, 10969 Berlin',
    time: 'Monday evening',
    contact: 'https://groups.google.com/forum/#!members/rubymonstaaa',
    activities: 'The group is now a mixture of old-timers and newcomers, and from the original group some are still working on SpeakerinnenListe, others are doing the Michael Hartl tutorial, and the newcomers have been doing general Ruby exercises. A sub-group is doing the Michael Hartl tutorial',
    email: 'group4@example.org'
  }
]

group_list.each do |group|
  Group.create!(group)
end

user_list = [
  {
    first_name: 'Student',
    last_name: 'Example',
    email: 'student@example.org',
    password: 'testtest',
    twitter: '@studenttwitter',
  },
  {
    first_name: 'Coach',
    last_name: 'Example',
    email: 'coach@example.org',
    password: 'testtest',
    twitter: '@coachtwitter',
  }
]
user_list.each do |user|
  Person.create!(user)
end