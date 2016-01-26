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
    address: 'modomoto office',
    time: 'Thursday 19:00',
    contact: 'https://groups.google.com/forum/#!forum/rails-girls-berlin-project-group-thursdays',
    activities: 'We build a wishlist app to organize christmas for large families. Users can enter their own wishlist and add wishes. Other users can comment on these wishes, mark them as done etc, but the list owner can’t see that of course.',
    email: 'group1@example.org',
    city: 'Berlin',
    country: 'DE',
    street: 'Blücherstraße 22',
    zip: '10961'
  },
  {
    name: 'The Rubycorns',
    address: 'Bitcrowd',
    time: 'Tuesday 19:00',
    contact: 'https://groups.google.com/forum/#!forum/rails-girls-berlin-project-group-tuesdays',
    activities: 'We basically meet and have coding sessions where we show of stuff as needed. Sometimes Tobi gives a presentation from his HU course or something. Basically everything including homeworks is pretty ad-hoc.',
    email: 'group2@example.org',
    city: 'Berlin',
    country: 'DE',
    street: 'Sanderstr. 28 ',
    zip: '12047'
  },
  {
    name: 'The Co.Up Group',
    address: 'co.up Coworking',
    time: 'Tuesday 19:00',
    contact: 'foo',
    activities: 'Nothing specific, we do exercises around basic web apps with Sinatra.',
    email: 'group3@example.org',
    city: 'Berlin',
    country: 'DE',
    street: 'Adalbertstraße 8',
    zip: '10999'
  },
  {
    name: 'The Ruby Monsters',
    address: 'Travis Office',
    time: 'Monday evening',
    contact: 'https://groups.google.com/forum/#!members/rubymonstaaa',
    activities: 'The group is now a mixture of old-timers and newcomers, and from the original group some are still working on SpeakerinnenListe, others are doing the Michael Hartl tutorial, and the newcomers have been doing general Ruby exercises. A sub-group is doing the Michael Hartl tutorial',
    email: 'group4@example.org',
    full: true,
    city: 'Berlin',
    country: 'DE',
    street: 'Prinzessinnenstr. 20',
    zip: '10969'
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
    country: 'CA',
    city: 'Toronto'
  },
  {
    first_name: 'Coach',
    last_name: 'Example',
    email: 'coach@example.org',
    password: 'testtest',
    twitter: '@coachtwitter',
    admin: true,
    country: 'US',
    city: 'New York'
  }
]
user_list.each do |user|
  Person.create!(user)
end

posts_list = [
  {
    title: 'What a day!',
    description: 'We did so much today it was incredible. Time for a beer',
    created_at: DateTime.yesterday,
    updated_at: DateTime.now,
    person_id: 1,
    draft: false
  },
  {
    title: 'What is even a button?!',
    description: 'Today we got confused and had serious conversations about the state of the world and of buttons',
    created_at: DateTime.yesterday,
    updated_at: DateTime.now,
    person_id: 2,
    draft: false
  }
]
posts_list.each do |post|
  Post.create!(post)
end
