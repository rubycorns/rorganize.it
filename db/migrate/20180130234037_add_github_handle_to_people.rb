class AddGithubHandleToPeople < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :github_handle, :string
  end
end
