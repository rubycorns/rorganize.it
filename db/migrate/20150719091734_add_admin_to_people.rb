class AddAdminToPeople < ActiveRecord::Migration
  def up
    add_column :people, :admin, :boolean, default: false, null: false
    
    execute "UPDATE people SET admin = 't' WHERE id IN(SELECT person_id FROM people_roles);"

    drop_table :roles
    drop_table :people_roles
  end

  def down
    remove_column :people, :admin

    create_table(:roles) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:people_roles, :id => false) do |t|
      t.references :person
      t.references :role
    end

    add_index(:roles, :name)
    add_index(:roles, [ :name, :resource_type, :resource_id ])
    add_index(:people_roles, [ :person_id, :role_id ])
  end
end
