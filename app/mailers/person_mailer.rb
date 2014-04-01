class PersonMailer < ActionMailer::Base
  default from: "railsgirlsapp@do-not-reply.com"

  def new_member_email(group, person)
    @group = group
    @person = person

    mail to: @group.email,
         subject: 'Your group has a new member!'
  end

end
