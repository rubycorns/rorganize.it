class DashboardsController < ApplicationController

  before_action :authenticate_person!
  before_action :ensure_admin_powers

  def show
    @admins, @non_admins = Person.all.partition { |person| person.admin? }
    @non_admins.sort!
    @admins.sort!
    @published_posts = Post.published_descending_order
    @unpublished_posts = Post.draft
    @groups = Group.all
  end
end
