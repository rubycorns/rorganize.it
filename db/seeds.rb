# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

groups = Group.create([
  { name: 'The Thursday Group', address: 'modomoto office, Blücherstraße 22, 10961 Berlin' },
  { name: 'The Rubycorns', address: 'Travis Office, Prinzessinnenstr. 20, 10969 Berlin' },
  { name: 'The Co.Up Group', address: 'co.up Coworking Adalbertstraße 8, 10999 Berlin' },
  { name: 'The Ruby Monsters', address: 'Travis Office, Prinzessinnenstr. 20, 10969 Berlin' }])
