class PagesController < ApplicationController

  def index
    @groups = Group.all
    @people = Person.all
    @students, @coaches = Membership.all.partition { |membership| membership.name == 'Student' }
  end

  def about
  end

  def welcome
  end

end
