class SetDefaultDraftOnOlderPosts < ActiveRecord::Migration
  def change
    Post.find_each do |post|
      if post.draft.blank?
        post.draft = false
        post.save!
      end
    end
  end
end
