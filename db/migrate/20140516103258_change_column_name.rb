class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :posts, :name, :author
  end
end
