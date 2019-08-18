class AddMastodonToTable < ActiveRecord::Migration[5.1]
  def change
    add_column :people, :mastodon, :string
    add_column :groups, :mastodon, :string
  end
end
