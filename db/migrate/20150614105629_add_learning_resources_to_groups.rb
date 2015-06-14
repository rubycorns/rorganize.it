class AddLearningResourcesToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :learning_resources, :text
  end
end
