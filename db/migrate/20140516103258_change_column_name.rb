class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :posts, :name, :author
  end
end
