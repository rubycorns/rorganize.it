class Comment < ApplicationRecord

  belongs_to :topic
  belongs_to :person

  validates :body, presence: true
  
end
