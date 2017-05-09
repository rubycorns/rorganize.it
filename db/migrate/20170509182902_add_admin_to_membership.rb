class AddAdminToMembership < ActiveRecord::Migration
  def up
    add_column :memberships, :admin, :boolean, default: false, null: false
    Membership.all.each do |m|
      if m.coach?
        m.admin = true
        m.save!
      end
    end
  end

  def down
    remove_column :memberships, :admin
  end
end
