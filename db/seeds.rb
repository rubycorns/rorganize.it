# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

group_list = [
  [
    'The Thursday Group',
    'modomoto office, Blücherstraße 22, 10961 Berlin',
    'Thursday 19:00',
    'https://groups.google.com/forum/#!forum/rails-girls-berlin-project-group-thursdays',
    'We build a wishlist app to organize christmas for large families. Users can enter their own wishlist and add wishes. Other users can comment on these wishes, mark them as done etc, but the list owner can’t see that of course.'
  ],
  [
    'The Rubycorns',
    'Travis Office, Prinzessinnenstr. 20, 10969 Berlin',
    'Tuesday 19:00',
    'https://groups.google.com/forum/#!forum/rails-girls-berlin-project-group-tuesdays',
    'We basically meet and have coding sessions where we show of stuff as needed. Sometimes Tobi gives a presentation from his HU course or something. Basically everything including homeworks is pretty ad-hoc.'
  ],
  [
    'The Co.Up Group',
    'co.up Coworking Adalbertstraße 8, 10999 Berlin',
    'Tuesday 19:00',
    '',
    'Nothing specific, we do exercises around basic web apps with Sinatra.'
  ],
  [
    'The Ruby Monsters',
    'Travis Office, Prinzessinnenstr. 20, 10969 Berlin',
    'Monday evening',
    'https://groups.google.com/forum/#!members/rubymonstaaa',
    'The group is now a mixture of old-timers and newcomers, and from the original group some are still working on SpeakerinnenListe, others are doing the Michael Hartl tutorial, and the newcomers have been doing general Ruby exercises. A sub-group is doing the Michael Hartl tutorial'
  ]
]

group_list.each do |name, address, time, contact, activity|
  Group.create( name: name, address: address, time: time, contact: contact, activities: activity)
end