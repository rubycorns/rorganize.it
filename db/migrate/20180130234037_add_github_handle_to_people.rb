class AddGithubHandleToPeople < ActiveRecord::Migration
  def change
    add_column :people, :github_handle, :string
  end
end
