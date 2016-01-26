class NotificationsController < ApplicationController

  before_action :authenticate_person!

  def index
    @notifications = Notification.all
  end

  def new
    @notification = Notification.new
  end

  def create

    group_id = params[:notification][:group].to_i
    group = Group.find(group_id)
    success = true
    unless group
      @notification = Notification.new(notification_params)
      @notification.person = Person.find(params[:notification][:person_id].to_i)
      success = @notification.save
    else
      group.memberships.map do |m|
        @notification = Notification.new(notification_params)
        @notification.person = m.person
        success = @notification.save
      end
    end

    if success
      redirect_to notifications_path, notice: 'A new notification was created. This calls for cake!'
    else
      redirect_to notifications_path, warning: 'Not cake yet! Looks like not all notifications were successful.'
    end
  end

  def update

    if @notification
      if @notification.update_attributes notification_params
        redirect_to notification_path(@notification), notice: 'Notification was updated. Let\'s have some cake.'
      else
        render action: 'edit'
      end
    else
      @notification = Notification.find(params[:id])
      if @notification.update_attributes notification_params
        redirect_to root_path, notice: 'Notification was updated. Let\'s have some cake.'
      else
        redirect_to root_path, notice: 'Could not update notification. Womp womp.'
      end
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_to root_path, notice: 'Notification was successfully deleted.'
  end

  private

  def notification_params
    params.require(:notification).permit(:person, :content, :viewed_at)
  end
end
