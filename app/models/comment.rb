class Comment < ActiveRecord::Base

  belongs_to :topic
  belongs_to :person

  validates :body, presence: true
  
end
