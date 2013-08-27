class StudentsController < ApplicationController

  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
     if @student.save
        redirect_to students_path, alert: 'New student successfully registered!'
     else
        render action: "new"
     end
  end

  def student_params
     params.require(:student).permit(:first_name, :last_name, :email, :group_id)
  end

end
