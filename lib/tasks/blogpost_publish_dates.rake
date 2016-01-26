task set_blogpost_published_at: :environment do
  puts "Finding blogposts with empty publish dates"
  posts = Post.where(published_at: nil)

  if posts.count > 0
    puts "There are #{posts.count} blogposts with empty publication dates. I'll change them!"

    posts.map do |post|
      post.update_attribute(:published_at, post.created_at)
    end

    puts "Done! have some cake!"
  else
    puts "Nothing to do here! Go have some cake."
  end
end
