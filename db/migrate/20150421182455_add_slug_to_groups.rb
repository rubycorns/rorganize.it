class AddSlugToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :slug, :string
  end
end
