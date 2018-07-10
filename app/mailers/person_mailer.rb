class PersonMailer < ActionMailer::Base
  default from: "noreply@rorganize.it"

  def new_member_email(group, person)
    @group = group
    @person = person
    @membership = Membership.where(person: @person, group: @group).first

    mail to: @group.email,
         subject: 'Your group has a new member!'
  end

  def invitation_accepted(group, person)
    @group = group
    @person = person

    mail to: @person.email,
         subject: "Your membership to #{@group.name} has been accepted!"
  end

  def invitation_rejected(group, person)
    @group = group
    @person = person

    mail to: @person.email,
         subject: "Your membership to #{@group.name} has been rejected."
  end

  def new_invitation(group, person)
    @group = group
    @person = person

    mail to: @group.email,
         subject: "#{@person.name} wants to join #{@group.name}!"
  end
end
