task set_slugs: :environment do
  puts "creating slugs for groups"
  Group.find_each(&:save)

  puts 'creating slugs for posts'
  Post.find_each(&:save)

  puts 'done! have some cake'
end