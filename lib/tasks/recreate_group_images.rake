
desc 'Recreate Group image versions' 
task recreate_group_images: :environment do 
  Group.all.each { |group| group.picture.recreate_versions! }
end