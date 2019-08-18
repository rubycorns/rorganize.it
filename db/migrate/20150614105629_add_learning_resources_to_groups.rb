class AddLearningResourcesToGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :learning_resources, :text
  end
end
