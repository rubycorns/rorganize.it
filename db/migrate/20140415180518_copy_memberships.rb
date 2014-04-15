class CopyMemberships < ActiveRecord::Migration
  def up
    Person.all.select { |person| person.group_id }.each do |person|
      Membership.create! group_id: person.group_id, person_id: person.id
    end
  end
  def down
    Membership.delete_all
  end
end
