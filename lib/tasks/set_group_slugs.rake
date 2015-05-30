task set_group_slugs: :environment do
  puts "Finding groups without slugs"
  groups = Group.where(slug: nil)
    
  groups.map do |group|
    group.update_attribute(:slug, group.name.parameterize)
  end

  puts 'done! have some cake'
end