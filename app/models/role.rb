class Role < ActiveRecord::Base
  has_and_belongs_to_many :people, :join_table => :people_roles
  belongs_to :resource, :polymorphic => true
  
  scopify
end
