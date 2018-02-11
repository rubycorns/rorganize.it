class PagesController < ApplicationController

  def index
    @groups = Group.all
    @membership_count = Membership.all.group(:type).count
  end

  def about
  end

  def welcome
  end

end
