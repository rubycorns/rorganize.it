class InvitesController < ApplicationController
  before_action :authenticate_person!
  before_action :set_invite, only: [:destroy]

  def create
    @invite = Invite.new(invite_params)
    @invite.save
    @group = @invite.group
    @person = Person.find(@invite.person_id)
    PersonMailer.new_invitation(@group, @person).deliver_now if @group.email.present?
    redirect_to group_path(@group), notice: "You've requested to join #{@invite.group.name}."
  end

  def accept
    @invite.person.join!(@invite.group)
    PersonMailer.invitation_accepted(@group, @person).deliver_now if @person.email.present?
    @message = "New member accepted, hopefully there will be cake!"
  end

  def reject
    PersonMailer.invitation_rejected(@group, @person).deliver_now if @person.email.present?
    @message = "Declined successfully, hopefully they'll have cake."
  end

  def destroy
    @state = invite_params[:state]
    @group = @invite.group
    @person = Person.find(@invite.person_id)
    accept if @state == 'true'
    reject if @state == 'false'
    @invite.destroy
    redirect_to group_path(@group), notice: @message
  end

  private

  def set_invite
    if params[:id]
      id = params[:id]
    else
      url = request.original_fullpath
      id = url.split('.')[1]
    end
    @invite = Invite.find(id)
  end

  def invite_params
    params.require(:invite).permit(:group_id, :person_id, :state)
  end

end
