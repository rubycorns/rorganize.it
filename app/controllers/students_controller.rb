class StudentsController < ApplicationController
  before_action :authenticate_person!

  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
  end
end
